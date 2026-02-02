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
    // ... (Código da busca igual ao anterior) ...
    const { q, page = 1, limit = 10 } = req.query;
    const offset = (page - 1) * limit;
    if (!q || q.length < 3) return res.json({ data: [], total: 0 }); 
    try {
        const termo = `%${q}%`;
        const sqlDados = `SELECT b.id, p.nome_completo, p.cpf FROM Beneficiario b JOIN pessoa p ON b.pessoa_id = p.id WHERE p.nome_completo LIKE ? OR p.cpf LIKE ? ORDER BY p.nome_completo ASC LIMIT ${limit} OFFSET ${offset}`;
        const sqlCount = `SELECT COUNT(*) as total FROM Beneficiario b JOIN pessoa p ON b.pessoa_id = p.id WHERE p.nome_completo LIKE ? OR p.cpf LIKE ?`;
        const [dados, countRes] = await Promise.all([querySys(sqlDados, [termo, termo]), querySys(sqlCount, [termo, termo])]);
        res.json({ data: dados, pagination: { total: countRes[0].total, page: parseInt(page), limit: parseInt(limit), totalPages: Math.ceil(countRes[0].total / limit) } });
    } catch (error) { res.status(500).json({ error: "Erro busca" }); }
});


router.get("/colaboradores/busca", verificarUsuario, async (req, res) => {
    const { q, page = 1, limit = 10 } = req.query;
    const offset = (page - 1) * limit;

    if (!q || q.length < 3) return res.json({ data: [], total: 0 }); 

    try {
        const termo = `%${q}%`;
        
        // Buscamos apenas quem tem perfil de PROFESSOR (ID 6) ou pode ser qualquer colaborador?
        // Vou deixar aberto para qualquer colaborador, mas você pode filtrar com "AND u.id_perfil_usuario = 6" se quiser
        const sqlDados = `
            SELECT c.id, p.nome_completo, p.cpf, c.email_institucional
            FROM colaborador c
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE p.nome_completo LIKE ? OR p.cpf LIKE ?
            ORDER BY p.nome_completo ASC
            LIMIT ? OFFSET ?
        `;

        const sqlCount = `
            SELECT COUNT(*) as total
            FROM colaborador c
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE p.nome_completo LIKE ? OR p.cpf LIKE ?
        `;

        const [dados, countRes] = await Promise.all([
            querySys(sqlDados, [termo, termo, parseInt(limit), parseInt(offset)]),
            querySys(sqlCount, [termo, termo])
        ]);

        res.json({
            data: dados,
            pagination: {
                total: countRes[0].total,
                page: parseInt(page),
                limit: parseInt(limit),
                totalPages: Math.ceil(countRes[0].total / limit)
            }
        });
    } catch (error) {
        res.status(500).json({ error: "Erro na busca de professores" });
    }
});
// --- ATUALIZADO: MATRÍCULA COM TRAVA DE PROJETO ÚNICO ---
router.post("/turmas/:id/matriculas", verificarUsuario, async (req, res) => {
    const { id: turmaId } = req.params;
    const { aluno_id } = req.body; 

    const matricularUmAluno = async (beneficiarioId) => {
        const [turma] = await querySys("SELECT projeto_id FROM turmas WHERE id = ?", [turmaId]);
        if (!turma) throw new Error("Turma não encontrada.");

        // Verifica conflito de projeto (Só para alunos ATIVOS em outros projetos)
        const sqlVerifica = `
            SELECT t.projeto_id, p.titulo
            FROM matriculas m
            JOIN turmas t ON m.turma_id = t.id
            JOIN projeto p ON t.projeto_id = p.id
            WHERE m.beneficiario_id = ? AND t.projeto_id != ? AND m.status = 'Ativo'
            LIMIT 1
        `;
        const conflito = await querySys(sqlVerifica, [beneficiarioId, turma.projeto_id]);
        if (conflito.length > 0) throw new Error(`Aluno ativo no projeto "${conflito[0].titulo}".`);

        // Verifica se já existe matrícula nesta turma (Ativa ou Inativa)
        const [existente] = await querySys("SELECT id, status FROM matriculas WHERE turma_id = ? AND beneficiario_id = ?", [turmaId, beneficiarioId]);

        if (existente) {
            if (existente.status !== 'Ativo') {
                // REATIVAR ALUNO ANTIGO
                await querySys("UPDATE matriculas SET status = 'Ativo' WHERE id = ?", [existente.id]);
            }
        } else {
            // CRIAR NOVO
            await querySys("INSERT INTO matriculas (turma_id, beneficiario_id, status) VALUES (?, ?, 'Ativo')", [turmaId, beneficiarioId]);
        }
    };

    try {
        const listaIds = Array.isArray(aluno_id) ? aluno_id : [aluno_id];
        const erros = [];
        for (const idAluno of listaIds) {
            try { await matricularUmAluno(idAluno); } catch (err) { erros.push(`ID ${idAluno}: ${err.message}`); }
        }
        if (erros.length > 0) return res.status(400).json({ error: "Alguns erros ocorreram.", detalhes: erros });
        res.status(201).json({ message: "Processado com sucesso!" });
    } catch (error) { res.status(500).json({ error: error.message }); }
});

// 5. ATUALIZAR TURMA (PUT)
router.put("/turmas/:id", verificarUsuario, async (req, res) => {
    const { id } = req.params;
    const { nome, turno, periodo, dias_aula, data_inicio, data_fim, ativo } = req.body;

    try {
        // Garante formato JSON para os dias
        const diasJSON = JSON.stringify(dias_aula || []);
        
        // Tratamento de datas nulas (pra não dar erro no banco)
        const inicioFormatado = data_inicio ? data_inicio : null;
        const fimFormatado = data_fim ? data_fim : null;

        // O 'ativo' vem do front. Se vier true/false, o MySQL converte pra 1/0, 
        // mas podemos forçar:
        const ativoBit = (ativo === true || ativo === 1 || ativo === '1') ? 1 : 0;

        const sql = `
            UPDATE turmas 
            SET nome = ?, turno = ?, periodo = ?, dias_aula = ?, 
                data_inicio = ?, data_fim = ?, ativo = ?
            WHERE id = ?
        `;
        
        await querySys(sql, [
            nome, turno, periodo, diasJSON, 
            inicioFormatado, fimFormatado, ativoBit, 
            id
        ]);

        res.json({ message: "Turma atualizada com sucesso!" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Erro ao atualizar turma." });
    }
});

// 2. LISTAR ALUNOS DA TURMA (⚠️ Essa é a que estava dando 404!)
router.get("/turmas/:id/matriculas", verificarUsuario, async (req, res) => {
    try {
        const turmaId = req.params.id;
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const offset = (page - 1) * limit;

        // FILTRO: AND m.status = 'Ativo'
        const sqlDados = `
            SELECT m.id as matricula_id, m.beneficiario_id, p.nome_completo, p.cpf
            FROM matriculas m
            JOIN Beneficiario b ON m.beneficiario_id = b.id
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE m.turma_id = ? AND m.status = 'Ativo'
            ORDER BY p.nome_completo ASC
            LIMIT ${limit} OFFSET ${offset}
        `;
        
        const sqlCount = `SELECT COUNT(*) as total FROM matriculas WHERE turma_id = ? AND status = 'Ativo'`;

        const [dados, countRes] = await Promise.all([querySys(sqlDados, [turmaId]), querySys(sqlCount, [turmaId])]);
        const total = countRes[0].total;

        res.json({ data: dados, pagination: { total, page, totalPages: Math.ceil(total / limit), limit } });
    } catch (error) { res.status(500).json({ error: error.message }); }
});

router.delete("/matriculas/:id", verificarUsuario, async (req, res) => {
    try {
        // UPDATE em vez de DELETE
        await querySys("UPDATE matriculas SET status = 'Inativo' WHERE id = ?", [req.params.id]);
        res.json({ message: "Aluno inativado. Histórico preservado." });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/turmas/:id/aulas", verificarUsuario, async (req, res) => {
    try {
        const turmaId = req.params.id;
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const offset = (page - 1) * limit;

        // Traz a aula e o nome do professor que registrou
        const sqlDados = `
            SELECT a.id, a.data_aula, a.conteudo, a.created_at,
                   p.nome_completo as professor_nome
            FROM aulas a
            JOIN colaborador c ON a.colaborador_id = c.id
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE a.turma_id = ?
            ORDER BY a.data_aula DESC, a.created_at DESC
            LIMIT ${limit} OFFSET ${offset}
        `;

        const sqlCount = `SELECT COUNT(*) as total FROM aulas WHERE turma_id = ?`;

        const [dados, countRes] = await Promise.all([
            querySys(sqlDados, [turmaId]),
            querySys(sqlCount, [turmaId])
        ]);

        // Para cada aula, vamos contar quantos Presentes/Ausentes tiveram (Resumo)
        // Isso evita ter que abrir a aula pra saber se veio gente
        const aulasComResumo = await Promise.all(dados.map(async (aula) => {
            const [resumo] = await querySys(`
                SELECT 
                    SUM(CASE WHEN status = 'Presente' THEN 1 ELSE 0 END) as presentes,
                    SUM(CASE WHEN status = 'Ausente' THEN 1 ELSE 0 END) as ausentes
                FROM frequencias WHERE aula_id = ?
            `, [aula.id]);
            return { ...aula, ...resumo[0] };
        }));

        res.json({
            data: aulasComResumo,
            pagination: {
                total: countRes[0].total,
                page,
                totalPages: Math.ceil(countRes[0].total / limit),
                limit
            }
        });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 2. DETALHES DA FREQUÊNCIA DE UMA AULA (Quem veio neste dia?)
router.get("/aulas/:id/frequencia", verificarUsuario, async (req, res) => {
    try {
        const sql = `
            SELECT f.status, p.nome_completo, p.cpf
            FROM frequencias f
            JOIN matriculas m ON f.matricula_id = m.id
            JOIN Beneficiario b ON m.beneficiario_id = b.id
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE f.aula_id = ?
            ORDER BY p.nome_completo ASC
        `;
        const results = await querySys(sql, [req.params.id]);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 4. GESTÃO DE PROFESSORES (VÍNCULOS)
router.get("/turmas/:id/professores", verificarUsuario, async (req, res) => {
    try {
        const turmaId = req.params.id;
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const offset = (page - 1) * limit;

        // MUDANÇA: Usamos 'tp.ativo = 1'
        const sqlDados = `
    SELECT 
        tp.id as vinculo_id, 
        tp.colaborador_id, 
        p.nome_completo, 
        p.cpf,                     -- <--- ADICIONAR ESTA LINHA AQUI
        c.email_institucional
    FROM turma_professores tp
    JOIN colaborador c ON tp.colaborador_id = c.id
    JOIN pessoa p ON c.pessoa_id = p.id
    WHERE tp.turma_id = ? AND tp.ativo = 1
    LIMIT ${limit} OFFSET ${offset}
`;

        const sqlCount = `SELECT COUNT(*) as total FROM turma_professores WHERE turma_id = ? AND ativo = 1`;

        const [dados, countRes] = await Promise.all([querySys(sqlDados, [turmaId]), querySys(sqlCount, [turmaId])]);
        const total = countRes[0].total;

        res.json({ data: dados, pagination: { total, page, totalPages: Math.ceil(total / limit), limit } });
    } catch (error) { res.status(500).json({ error: error.message }); }
});

router.post("/turmas/:id/professores", verificarUsuario, async (req, res) => {
    const { id: turmaId } = req.params;
    const { professor_id } = req.body; 

    const vincularUmProf = async (colaboradorId) => {
        // Verifica se já existe (Ativo ou Inativo)
        const [existente] = await querySys(
            "SELECT id, ativo FROM turma_professores WHERE turma_id = ? AND colaborador_id = ?", 
            [turmaId, colaboradorId]
        );

        if (existente) {
            if (existente.ativo === 0) { // Se for 0 (Inativo), a gente reativa
                await querySys("UPDATE turma_professores SET ativo = 1 WHERE id = ?", [existente.id]);
            }
        } else {
            // Cria novo já com ativo = 1
            await querySys(
                "INSERT INTO turma_professores (turma_id, colaborador_id, ativo) VALUES (?, ?, 1)", 
                [turmaId, colaboradorId]
            );
        }
    };

    try {
        const listaIds = Array.isArray(professor_id) ? professor_id : [professor_id];
        for (const idProf of listaIds) {
            try { await vincularUmProf(idProf); } catch (e) { }
        }
        res.status(201).json({ message: "Professores vinculados!" });
    } catch (error) {
        res.status(500).json({ error: "Erro ao vincular." });
    }
});

router.delete("/turma-professores/:id", verificarUsuario, async (req, res) => {
    try {
        // UPDATE para ativo = 0
        await querySys("UPDATE turma_professores SET ativo = 0 WHERE id = ?", [req.params.id]);
        res.json({ message: "Professor desvinculado." });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/dashboard/resumo", verificarUsuario, async (req, res) => {
    try {
        // 1. Contadores (O destructuring [variavel] já pega o primeiro item do array)
        const [turmasAtivas] = await querySys("SELECT COUNT(*) as total FROM turmas WHERE ativo = 1");
        const [turmasEncerradas] = await querySys("SELECT COUNT(*) as total FROM turmas WHERE ativo = 0");
        const [alunosAtivos] = await querySys("SELECT COUNT(*) as total FROM matriculas WHERE status = 'Ativo'");
        const [profsVinculados] = await querySys("SELECT COUNT(*) as total FROM turma_professores WHERE ativo = 1");

        // 2. ALERTAS
        const sqlSemProf = `
            SELECT t.id, t.nome, p.titulo as projeto 
            FROM turmas t
            JOIN projeto p ON t.projeto_id = p.id
            WHERE t.ativo = 1 
            AND t.id NOT IN (SELECT turma_id FROM turma_professores WHERE ativo = 1)
            LIMIT 5
        `;
        const turmasSemProfessor = await querySys(sqlSemProf);

        // 3. RECENTES
        const sqlRecentes = `
            SELECT t.id, t.nome, t.periodo, p.titulo as projeto
            FROM turmas t
            JOIN projeto p ON t.projeto_id = p.id
            ORDER BY t.created_at DESC
            LIMIT 5
        `;
        const turmasRecentes = await querySys(sqlRecentes);

        res.json({
            counters: {
                // CORREÇÃO AQUI: Removemos o [0] pois a variável já é o objeto
                turmas_ativas: turmasAtivas?.total || 0,
                turmas_encerradas: turmasEncerradas?.total || 0,
                alunos_matriculados: alunosAtivos?.total || 0,
                professores_alocados: profsVinculados?.total || 0
            },
            alertas: turmasSemProfessor,
            recentes: turmasRecentes
        });
    } catch (error) {
        console.error("Erro dashboard:", error);
        res.status(500).json({ error: "Erro ao carregar dashboard" });
    }
});

// 4. LISTAR TODOS OS PROFESSORES DO SISTEMA (Para a tela geral)
router.get("/professores/geral", verificarUsuario, async (req, res) => {
    try {
        // Busca professor + Contagem de turmas ativas que ele tem
        const sql = `
            SELECT c.id, p.nome_completo, p.cpf, c.email_institucional,
            (SELECT COUNT(*) FROM turma_professores tp 
             WHERE tp.colaborador_id = c.id AND tp.ativo = 1) as total_turmas
            FROM colaborador c
            JOIN pessoa p ON c.pessoa_id = p.id
            ORDER BY p.nome_completo ASC
        `;
        const results = await querySys(sql);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: "Erro ao listar professores." });
    }
});


router.get("/integracao", (req, res) => {
    res.send("API DE INTEGRAÇÃO RODANDO 🚀");
});

module.exports = router;