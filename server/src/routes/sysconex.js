const express = require('express');
const router = express.Router();
const { dbSysConex, querySys } = require('../config/database');

const bcrypt = require('bcryptjs'); // Para comparar a senha criptografada
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.SECRET_KEY;


const verificarTokenIntegracao = (req, res, next) => {
    const tokenSecreto = process.env.SYSCONEX_API_TOKEN; // Pega do .env
    const tokenRecebido = req.headers['x-sysconex-token']; // O Rhian tem que mandar esse header

    // Segurança para você: Se esquecer de por no .env, ele avisa e bloqueia tudo
    if (!tokenSecreto) {
        console.error("❌ ERRO CRÍTICO: Variável SYSCONEX_API_TOKEN não definida no .env");
        return res.status(500).json({ error: "Erro interno de configuração de segurança." });
    }

    // A Comparação
    if (tokenRecebido !== tokenSecreto) {
        console.warn(`⛔ Tentativa de acesso negada. IP: ${req.ip}`);
        return res.status(403).json({ error: 'Acesso negado: Token de segurança inválido ou ausente.' });
    }

    next(); // Se passar, segue para a função de salvar no banco
};

const verificarUsuario = (req, res, next) => {
    // 1. Pega o cabeçalho "Authorization: Bearer <token>"
    const authHeader = req.headers['authorization'];
    
    // 2. Separa o "Bearer" do Token em si
    const token = authHeader && authHeader.split(' ')[1]; 

    // 3. Se não tiver token, barra na porta
    if (!token) return res.status(401).json({ error: "Acesso negado. Faça login." });

    // 4. Verifica se o token é válido e não expirou
    jwt.verify(token, JWT_SECRET, (err, user) => {
        if (err) return res.status(403).json({ error: "Sessão inválida ou expirada." });
        
        // 5. Se tudo certo, guarda os dados do usuário na requisição e deixa passar
        req.user = user; 
        next();
    });
};

router.post("/auth/login", async (req, res) => {
    const { login, senha } = req.body; // No front vamos mandar { login: 'CPF', senha: '...' }

    try {
        // 1. Busca o usuário no banco pelo Login (CPF)
        // Trazemos também o nome da pessoa para exibir no Front
        const sql = `
            SELECT u.id, u.login, u.senha, u.id_perfil_usuario, p.descricao as perfil, pes.nome_completo
            FROM usuario u
            JOIN perfil_usuario p ON u.id_perfil_usuario = p.id
            JOIN colaborador c ON u.id_colaborador = c.id
            JOIN pessoa pes ON c.pessoa_id = pes.id
            WHERE u.login = ? AND u.status = 1
        `;
        
        const results = await querySys(sql, [login]);

        // 2. Verifica se usuário existe
        if (results.length === 0) {
            return res.status(401).json({ error: "Usuário não encontrado ou inativo." });
        }

        const usuario = results[0];
        

        // 3. Compara a senha enviada com o Hash do banco
        const senhaBate = await bcrypt.compare(senha, usuario.senha);
        
        if (!senhaBate) {
            return res.status(401).json({ error: "Senha incorreta." });
        }

        // 4. Gera o Token de Acesso (O "Crachá" digital)
        const token = jwt.sign(
            { 
                id: usuario.id, 
                perfil: usuario.id_perfil_usuario, 
                nome: usuario.nome_completo 
            },
            JWT_SECRET,
            { expiresIn: '8h' } // Token expira em 8 horas
        );

        // 5. Devolve tudo pro Frontend
        res.json({
            message: "Login realizado com sucesso!",
            token,
            user: {
                nome: usuario.nome_completo,
                perfil: usuario.perfil,
                perfil_id: usuario.id_perfil_usuario
            }
        });

    } catch (error) {
        console.error("Erro no Login:", error);
        res.status(500).json({ error: "Erro interno ao realizar login." });
    }
});





router.post("/integracao/receber-dados", verificarTokenIntegracao, async (req, res) => {
    const listaUsuarios = req.body;

    if (!Array.isArray(listaUsuarios)) {
        return res.status(400).json({ error: "O corpo deve ser uma lista JSON." });
    }

    dbSysConex.getConnection(async (err, connection) => {
        if (err) return res.status(500).json({ error: "Erro de conexão com banco." });

        const queryTx = (sql, params) => {
            return new Promise((resolve, reject) => {
                connection.query(sql, params, (e, r) => e ? reject(e) : resolve(r));
            });
        };

        try {
            await new Promise((resolve, reject) => connection.beginTransaction(e => e ? reject(e) : resolve()));

            let criados = 0;
            let atualizados = 0;

            for (const u of listaUsuarios) {
                if (!u.cpf) continue; 
                const cpfLimpo = u.cpf.replace(/\D/g, '');

                const rows = await queryTx("SELECT id FROM pessoa WHERE cpf = ?", [cpfLimpo]);
                
                let pessoaId;
                
                const defaults = {
                    mae: u.nome_mae || "NÃO INFORMADO",
                    gen: u.genero_id || 1,
                    etn: u.etnia_id || 1
                };

                if (rows.length > 0) {
                    // UPDATE (Sem email aqui, pois 'pessoa' não tem email)
                    pessoaId = rows[0].id;
                    await queryTx("UPDATE pessoa SET nome_completo = ? WHERE id = ?", [u.nome_completo, pessoaId]);
                    
                    // Atualiza o contato (email) separadamente
                    const checkContato = await queryTx("SELECT id FROM contato WHERE pessoa_id = ?", [pessoaId]);
                    if (checkContato.length > 0) {
                        await queryTx("UPDATE contato SET email = ? WHERE id = ?", [u.email, checkContato[0].id]);
                    } else {
                        await queryTx("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                    }
                    
                    atualizados++;
                } else {
                    // INSERT (Sem email na tabela pessoa)
                    const sqlInsert = `
                        INSERT INTO pessoa (nome_completo, cpf, data_nasc, nome_mae, naturalidade, nacionalidade, genero_id, etnia_id, escolaridade_id, orgao_emissor_id) 
                        VALUES (?, ?, ?, ?, 'BRASIL', 'BRASIL', ?, ?, 1, 1)
                    `;
                    const resPessoa = await queryTx(sqlInsert, [
                        u.nome_completo, cpfLimpo, u.data_nasc || '2000-01-01', defaults.mae, defaults.gen, defaults.etn
                    ]);
                    pessoaId = resPessoa.insertId;

                    // Salva o email na tabela contato
                    if (u.email) {
                        await queryTx("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                    }

                    criados++;
                }

                // Lógica ALUNO vs PROFESSOR
                if (u.tipo === "ALUNO") {
                    const checkBenef = await queryTx("SELECT id FROM Beneficiario WHERE pessoa_id = ?", [pessoaId]);
                    if (checkBenef.length === 0) {
                        await queryTx("INSERT INTO Beneficiario (pessoa_id, id_projeto, id_processo_inscricao) VALUES (?, ?, 1)", [pessoaId, u.projeto_id || 1]);
                    }
                } else if (u.tipo === "PROFESSOR") {
                    // Cria Colaborador
                    const checkColab = await queryTx("SELECT id FROM colaborador WHERE pessoa_id = ?", [pessoaId]);
                    let colabId;
                    if (checkColab.length === 0) {
                        // Colaborador tem 'email_institucional'
                        const resColab = await queryTx("INSERT INTO colaborador (pessoa_id, cargo_id, email_institucional) VALUES (?, ?, ?)", [pessoaId, u.cargo_id || 6, u.email || 'sem_email@inst.com']);
                        colabId = resColab.insertId;
                    } else {
                        colabId = checkColab[0].id;
                    }
                    // Cria Usuário
                    const checkUser = await queryTx("SELECT id FROM usuario WHERE id_colaborador = ?", [colabId]);
                    if (checkUser.length === 0) {
                        await queryTx(
                            "INSERT INTO usuario (id_colaborador, id_perfil_usuario, login, senha, status) VALUES (?, 6, ?, '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1)",
                            [colabId, cpfLimpo]
                        );
                    }
                }
            }

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));
            
            res.status(200).json({ 
                message: "Sincronização realizada com sucesso!", 
                resumo: { criados, atualizados }
            });

        } catch (error) {
            connection.rollback(() => {});
            console.error("Erro Webhook:", error);
            res.status(500).json({ 
                error: "Erro no processamento: " + error.message, 
                sql_erro: error.sqlMessage || "Sem detalhe SQL" 
            });
        } finally {
            connection.release();
        }
    });
});


// ... imports e configs anteriores (bcrypt, jwt, dbSysConex) ...

// ==========================================
// 🎓 ÁREA DO COORDENADOR
// ==========================================

// 1. SELECT DE PROJETOS (Para o Dropdown)
router.get("/projetos", verificarUsuario, async (req, res) => {
    try {
        const results = await querySys("SELECT id, titulo FROM projeto WHERE status = 'ativo' ORDER BY titulo ASC");
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: "Erro ao buscar projetos" });
    }
});

// 2. CRUD DE TURMAS
router.get("/turmas", verificarUsuario, async (req, res) => {
    try {
        // Traz as turmas com o nome do projeto junto
        const sql = `
            SELECT t.*, p.titulo as nome_projeto 
            FROM turmas t
            LEFT JOIN projeto p ON t.projeto_id = p.id
            ORDER BY t.id DESC
        `;
        const results = await querySys(sql);
        
        const turmasFormatadas = results.map(t => ({
            ...t,
            dias_aula: JSON.parse(t.dias_aula || "[]"),
            ativo: t.ativo === 1
        }));
        res.json(turmasFormatadas);
    } catch (error) {
        res.status(500).json({ error: "Erro ao buscar turmas" });
    }
});

// Crie/Substitua a rota POST /turmas por esta versão:

router.post("/turmas", verificarUsuario, async (req, res) => {
    // 1. Recebe os dados do Front
    const { projeto_id, nome, turno, periodo, dias_aula, data_inicio, data_fim } = req.body;

    try {
        // 2. TRATAMENTO DE DADOS (Sanitização)
        // Se a data vier vazia (""), transformamos em NULL pro banco aceitar
        const inicioFormatado = data_inicio ? data_inicio : null;
        const fimFormatado = data_fim ? data_fim : null;
        
        // Garante que dias_aula seja sempre um JSON válido, mesmo se vier vazio
        const diasJSON = JSON.stringify(dias_aula || []);

        const sql = `
            INSERT INTO turmas 
            (projeto_id, nome, turno, periodo, dias_aula, data_inicio, data_fim) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `;
        
        const values = [
            projeto_id, 
            nome, 
            turno, 
            periodo, 
            diasJSON, 
            inicioFormatado, // Usa a variável tratada
            fimFormatado     // Usa a variável tratada
        ];

        const result = await querySys(sql, values);
        
        res.status(201).json({ 
            message: "Turma criada com sucesso!", 
            id: result.insertId 
        });

    } catch (error) {
        console.error("Erro ao criar turma:", error);
        res.status(500).json({ error: "Erro ao criar turma: " + error.message });
    }
});

router.get("/turmas/:id", verificarUsuario, async (req, res) => {
    try {
        const results = await querySys("SELECT * FROM turmas WHERE id = ?", [req.params.id]);
        if (results.length === 0) return res.status(404).json({ error: "Turma não encontrada" });
        
        const turma = results[0];
        turma.dias_aula = JSON.parse(turma.dias_aula || "[]");
        turma.ativo = turma.ativo === 1;
        res.json(turma); 
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 3. GESTÃO DE ALUNOS (MATRÍCULAS)
// --- NOVO: BUSCA DE BENEFICIÁRIOS (Para o Modal) ---
router.get("/beneficiarios/busca", verificarUsuario, async (req, res) => {
    const { q } = req.query; // Termo de busca (nome ou cpf)
    if (!q || q.length < 3) return res.json([]); // Só busca com 3+ caracteres

    try {
        const sql = `
            SELECT b.id, p.nome_completo, p.cpf
            FROM Beneficiario b
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE p.nome_completo LIKE ? OR p.cpf LIKE ?
            LIMIT 10
        `;
        const termo = `%${q}%`;
        const results = await querySys(sql, [termo, termo]);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: "Erro na busca" });
    }
});

// --- ATUALIZADO: MATRÍCULA COM TRAVA DE PROJETO ÚNICO ---
router.post("/turmas/:id/matriculas", verificarUsuario, async (req, res) => {
    const { id: turmaId } = req.params;
    const { aluno_id } = req.body; // Pode vir um ID ou um ARRAY de IDs

    // Função auxiliar para matricular UM aluno com as regras
    const matricularUmAluno = async (beneficiarioId) => {
        // 1. Descobrir qual é o projeto dessa turma
        const [turma] = await querySys("SELECT projeto_id FROM turmas WHERE id = ?", [turmaId]);
        if (!turma) throw new Error("Turma não encontrada.");

        // 2. REGRA DE OURO: O aluno já está em outro projeto?
        // Buscamos se existe alguma matrícula desse aluno em turmas de OUTROS projetos
        const sqlVerifica = `
            SELECT t.projeto_id, p.titulo
            FROM matriculas m
            JOIN turmas t ON m.turma_id = t.id
            JOIN projeto p ON t.projeto_id = p.id
            WHERE m.beneficiario_id = ? 
            AND t.projeto_id != ? 
            LIMIT 1
        `;
        const conflito = await querySys(sqlVerifica, [beneficiarioId, turma.projeto_id]);

        if (conflito.length > 0) {
            throw new Error(`Aluno já pertence ao projeto "${conflito[0].titulo}".`);
        }

        // 3. Se passou, insere (Ignora se já tiver na mesma turma com INSERT IGNORE ou try/catch)
        await querySys("INSERT INTO matriculas (turma_id, beneficiario_id, status) VALUES (?, ?, 'Ativo')", [turmaId, beneficiarioId]);
    };

    try {
        // Suporta tanto { aluno_id: 1 } quanto { aluno_id: [1, 2, 3] }
        const listaIds = Array.isArray(aluno_id) ? aluno_id : [aluno_id];
        
        // Processa todos (Promise.all para ser rápido)
        // Se um falhar (regra do projeto), a gente avisa
        const erros = [];
        for (const idAluno of listaIds) {
            try {
                await matricularUmAluno(idAluno);
            } catch (err) {
                // Se for erro de duplicidade na mesma turma, ignora. Se for regra de projeto, guarda o erro.
                if (!err.message.includes('Duplicate entry')) {
                    erros.push(`ID ${idAluno}: ${err.message}`);
                }
            }
        }

        if (erros.length > 0) {
            // Retorna sucesso parcial ou erro
            return res.status(400).json({ error: "Alguns alunos não foram matriculados.", detalhes: erros });
        }

        res.status(201).json({ message: "Alunos matriculados com sucesso!" });

    } catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
});

// 2. LISTAR ALUNOS DA TURMA (⚠️ Essa é a que estava dando 404!)
router.get("/turmas/:id/matriculas", verificarUsuario, async (req, res) => {
    try {
        const sql = `
            SELECT m.id as matricula_id, m.beneficiario_id, p.nome_completo, p.cpf
            FROM matriculas m
            JOIN Beneficiario b ON m.beneficiario_id = b.id
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE m.turma_id = ?
            ORDER BY p.nome_completo ASC
        `;
        const results = await querySys(sql, [req.params.id]);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete("/matriculas/:id", verificarUsuario, async (req, res) => {
    try {
        await querySys("DELETE FROM matriculas WHERE id = ?", [req.params.id]);
        res.json({ message: "Matrícula removida." });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 4. GESTÃO DE PROFESSORES (VÍNCULOS)
router.get("/turmas/:id/professores", verificarUsuario, async (req, res) => {
    try {
        const sql = `
            SELECT tp.id as vinculo_id, tp.colaborador_id, p.nome_completo, c.email_institucional
            FROM turma_professores tp
            JOIN colaborador c ON tp.colaborador_id = c.id
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE tp.turma_id = ?
        `;
        const results = await querySys(sql, [req.params.id]);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post("/turmas/:id/professores", verificarUsuario, async (req, res) => {
    try {
        await querySys("INSERT INTO turma_professores (turma_id, colaborador_id) VALUES (?, ?)", [req.params.id, req.body.professor_id]);
        res.status(201).json({ message: "Professor vinculado!" });
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') return res.status(400).json({ error: "Professor já está vinculado." });
        res.status(500).json({ error: error.message });
    }
});

router.delete("/turma-professores/:id", verificarUsuario, async (req, res) => {
    try {
        await querySys("DELETE FROM turma_professores WHERE id = ?", [req.params.id]);
        res.json({ message: "Professor desvinculado." });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});



router.get("/integracao", (req, res) => {
    res.send("API DE INTEGRAÇÃO RODANDO 🚀");
});

module.exports = router;