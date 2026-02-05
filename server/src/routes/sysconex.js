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

// HELPER DE SEGURANÇA: Verifica se o usuário (Professor) tem vínculo com a turma
const verificarAcessoProfessorTurma = async (usuarioId, turmaId) => {
    // 1. Busca perfil e colaborador_id
    const [user] = await querySys("SELECT id_colaborador, id_perfil_usuario FROM usuario WHERE id = ?", [usuarioId]);

    // Se não achar user, bloqueia
    if (!user) return false;

    // Se NÃO for professor (ex: Coordenador, Admin - Perfil != 6), permitimos acesso (regra de negócio a confirmar, mas seguro por enquanto)
    // Vamos assumir que coordenador (perfil 1, 2 etc) pode tudo.
    if (user.id_perfil_usuario !== 6) return true;

    // Se for professor, TEM que ter vínculo ativo com a turma
    const [vinculo] = await querySys(
        "SELECT id FROM turma_professores WHERE turma_id = ? AND colaborador_id = ? AND ativo = 1",
        [turmaId, user.id_colaborador]
    );

    return !!vinculo;
};

const verificarAcessoProfessorAula = async (usuarioId, aulaId) => {
    // 1. Descobre a turma da aula
    const [aula] = await querySys("SELECT turma_id FROM aulas WHERE id = ?", [aulaId]);
    if (!aula) return false; // Aula não existe

    // 2. Reutiliza a verificação de turma
    return await verificarAcessoProfessorTurma(usuarioId, aula.turma_id);
}

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
            connection.rollback(() => { });
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
    const { q, page = 1, limit = 10, projeto_id } = req.query;
    const offset = (page - 1) * limit;

    // Se não tiver busca nem projeto, retorna vazio (evita listar base toda)
    if ((!q || q.length < 3) && !projeto_id) {
        return res.json({ data: [], total: 0 });
    }

    try {
        const paramsDados = [];
        const paramsCount = [];
        let whereClause = "WHERE 1=1";

        // Filtro de Texto (Nome/CPF)
        if (q && q.length >= 3) {
            const termo = `%${q}%`;
            whereClause += " AND (p.nome_completo LIKE ? OR p.cpf LIKE ?)";
            paramsDados.push(termo, termo);
            paramsCount.push(termo, termo);
        }

        // Filtro de Projeto (Rigorous)
        if (projeto_id) {
            whereClause += " AND b.id_projeto = ?";
            paramsDados.push(projeto_id);
            paramsCount.push(projeto_id);
        }

        const sqlDados = `
            SELECT b.id, p.nome_completo, p.cpf, pr.titulo as nome_projeto
            FROM Beneficiario b 
            JOIN pessoa p ON b.pessoa_id = p.id 
            JOIN projeto pr ON b.id_projeto = pr.id
            ${whereClause} 
            ORDER BY p.nome_completo ASC 
            LIMIT ${limit} OFFSET ${offset}
        `;

        const sqlCount = `
            SELECT COUNT(*) as total 
            FROM Beneficiario b 
            JOIN pessoa p ON b.pessoa_id = p.id 
            ${whereClause}
        `;

        const [dados, countRes] = await Promise.all([
            querySys(sqlDados, paramsDados),
            querySys(sqlCount, paramsCount)
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
        console.error(error);
        res.status(500).json({ error: "Erro busca" });
    }
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
        // VERIFICAÇÃO: Se a turma estiver encerrada (ativo=0), bloqueia alteração
        // EXCETO se a intenção for reativá-la (ativo=1 no body)
        const [turmaAtual] = await querySys("SELECT ativo FROM turmas WHERE id = ?", [id]);

        if (turmaAtual && turmaAtual.ativo === 0) {
            // Verifica se o usuário está tentando reativar
            // O front manda true/false ou 1/0, vamos padronizar
            const tentandoReativar = (ativo === true || ativo === 1 || ativo === '1');

            if (!tentandoReativar) {
                return res.status(403).json({ error: "Não é permitido alterar dados de uma turma encerrada. Reative-a primeiro." });
            }
        }

        // Garante formato JSON para os dias
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

        // VERIFICAÇÃO DE SEGURANÇA
        if (!(await verificarAcessoProfessorTurma(req.user.id, turmaId))) {
            return res.status(403).json({ error: "Acesso negado. Você não é professor desta turma." });
        }

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
        await querySys("UPDATE matriculas SET status = 'Desistente' WHERE id = ?", [req.params.id]);
        res.json({ message: "Aluno marcado como desistente. Histórico preservado." });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 1. REGISTRAR AULA E FREQUÊNCIA (Nova Rota)
router.post("/turmas/:id/aulas", verificarUsuario, async (req, res) => {
    const { id: turmaId } = req.params;
    const { professor_id, data_aula, conteudo, lista_presenca } = req.body;

    // VERIFICAÇÃO DE SEGURANÇA
    if (!(await verificarAcessoProfessorTurma(req.user.id, turmaId))) {
        return res.status(403).json({ error: "Acesso negado. Você não tem permissão para registrar aula nesta turma." });
    }

    dbSysConex.getConnection(async (err, connection) => {
        if (err) return res.status(500).json({ error: "Erro de conexão." });

        const queryTx = (sql, params) => {
            return new Promise((resolve, reject) => {
                connection.query(sql, params, (e, r) => e ? reject(e) : resolve(r));
            });
        };

        try {
            await new Promise((resolve, reject) => connection.beginTransaction(e => e ? reject(e) : resolve()));

            // 1. Resolve Colaborador ID pelo Usuario ID (professor_id ou token)
            const idUsuario = professor_id || req.user.id;
            const rowsUser = await queryTx("SELECT id_colaborador FROM usuario WHERE id = ?", [idUsuario]);

            if (rowsUser.length === 0) throw new Error("Usuário/Professor não encontrado.");
            const colaboradorId = rowsUser[0].id_colaborador;

            // 2. Cria a Aula
            // OBS: A tabela 'aulas' tem 'numero_aulas' (default 1). Vamos passar explicitamente.
            const resAula = await queryTx(
                "INSERT INTO aulas (turma_id, colaborador_id, data_aula, conteudo, numero_aulas) VALUES (?, ?, ?, ?, ?)",
                [turmaId, colaboradorId, data_aula, conteudo, 1]
            );
            const aulaId = resAula.insertId;

            // 3. Salva Frequências
            // OBS: A tabela 'frequencias' tem 'observacao' (default NULL).vamos passar NULL.
            if (lista_presenca && Array.isArray(lista_presenca)) {
                for (const reg of lista_presenca) {
                    await queryTx(
                        "INSERT INTO frequencias (aula_id, matricula_id, status, observacao) VALUES (?, ?, ?, ?)",
                        [aulaId, reg.matricula_id, reg.status, reg.observacao || null]
                    );
                }
            }

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));
            res.status(201).json({ message: "Aula e frequência registradas!", id: aulaId });

        } catch (error) {
            connection.rollback(() => { });
            console.error("Erro ao salvar aula:", error);
            res.status(500).json({ error: "Erro ao registrar aula: " + error.message });
        } finally {
            connection.release();
        }
    });
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

// 3. EDITAR AULA E FREQUÊNCIA
router.put("/aulas/:id", verificarUsuario, async (req, res) => {
    const { id } = req.params;
    const { data_aula, conteudo, lista_presenca } = req.body;

    // VERIFICAÇÃO DE SEGURANÇA
    if (!(await verificarAcessoProfessorAula(req.user.id, id))) {
        return res.status(403).json({ error: "Acesso negado. Você não pode editar esta aula." });
    }

    dbSysConex.getConnection(async (err, connection) => {
        if (err) return res.status(500).json({ error: "Erro de conexão." });

        const queryTx = (sql, params) => {
            return new Promise((resolve, reject) => {
                connection.query(sql, params, (e, r) => e ? reject(e) : resolve(r));
            });
        };

        try {
            await new Promise((resolve, reject) => connection.beginTransaction(e => e ? reject(e) : resolve()));

            // 1. Atualizar dados básicos da aula
            await queryTx(
                "UPDATE aulas SET data_aula = ?, conteudo = ? WHERE id = ?",
                [data_aula, conteudo, id]
            );

            // 2. Atualizar frequências
            // Estratégia: Iterar e fazer UPDATE individual. Se não existir, faz INSERT (caso aluno novo tenha entrado na turma, por exemplo)
            // Para simplificar, vamos assumir que a lista vem completa.
            if (lista_presenca && Array.isArray(lista_presenca)) {
                for (const reg of lista_presenca) {
                    // Tenta atualizar
                    const resultUpdate = await queryTx(
                        "UPDATE frequencias SET status = ?, observacao = ? WHERE aula_id = ? AND matricula_id = ?",
                        [reg.status, reg.observacao || null, id, reg.matricula_id]
                    );

                    // Se não afetou nenhuma linha (aluno não tinha frequência lançada pra essa aula), INSERE
                    if (resultUpdate.affectedRows === 0) {
                        await queryTx(
                            "INSERT INTO frequencias (aula_id, matricula_id, status, observacao) VALUES (?, ?, ?, ?)",
                            [id, reg.matricula_id, reg.status, reg.observacao || null]
                        );
                    }
                }
            }

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));
            res.json({ message: "Aula atualizada com sucesso!" });

        } catch (error) {
            connection.rollback(() => { });
            console.error("Erro ao atualizar aula:", error);
            res.status(500).json({ error: "Erro ao atualizar aula." });
        } finally {
            connection.release();
        }
    });
});

// 4. EXCLUIR AULA
router.delete("/aulas/:id", verificarUsuario, async (req, res) => {
    const { id } = req.params;

    // VERIFICAÇÃO DE SEGURANÇA
    if (!(await verificarAcessoProfessorAula(req.user.id, id))) {
        return res.status(403).json({ error: "Acesso negado. Você não pode excluir esta aula." });
    }

    dbSysConex.getConnection(async (err, connection) => {
        if (err) return res.status(500).json({ error: "Erro de conexão." });

        const queryTx = (sql, params) => {
            return new Promise((resolve, reject) => {
                connection.query(sql, params, (e, r) => e ? reject(e) : resolve(r));
            });
        };

        try {
            await new Promise((resolve, reject) => connection.beginTransaction(e => e ? reject(e) : resolve()));

            // 1. Excluir Frequências Primeiro (Constraint FK)
            await queryTx("DELETE FROM frequencias WHERE aula_id = ?", [id]);

            // 2. Excluir Aula
            await queryTx("DELETE FROM aulas WHERE id = ?", [id]);

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));
            res.json({ message: "Aula excluída com sucesso!" });

        } catch (error) {
            connection.rollback(() => { });
            console.error("Erro ao excluir aula:", error);
            res.status(500).json({ error: "Erro ao excluir aula." });
        } finally {
            connection.release();
        }
    });
});

router.get("/aulas/:id/frequencia", verificarUsuario, async (req, res) => {
    try {
        // VERIFICAÇÃO DE SEGURANÇA
        if (!(await verificarAcessoProfessorAula(req.user.id, req.params.id))) {
            return res.status(403).json({ error: "Acesso negado." });
        }

        const sql = `
            SELECT f.status, f.observacao, f.matricula_id, p.nome_completo, p.cpf
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
        const [profsVinculados] = await querySys(`
            SELECT COUNT(*) as total 
            FROM turma_professores tp
            JOIN turmas t ON tp.turma_id = t.id
            JOIN projeto p ON t.projeto_id = p.id
            WHERE tp.ativo = 1 AND p.status = 'ativo' AND t.ativo = 1
        `);

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

// 4. LISTAR SOMENTE PROFESSORES (Perfil 6) - AJUSTADO PARA SEU BANCO
router.get("/professores/geral", verificarUsuario, async (req, res) => {
    try {
        const sql = `
            SELECT c.id, p.nome_completo, p.cpf, c.email_institucional,
            -- Subquery para contar turmas ativas
            (SELECT COUNT(*) FROM turma_professores tp 
             WHERE tp.colaborador_id = c.id AND tp.ativo = 1) as total_turmas
            
            FROM colaborador c
            JOIN pessoa p ON c.pessoa_id = p.id
            JOIN usuario u ON u.id_colaborador = c.id  -- <--- AQUI ESTAVA O SEGREDO
            WHERE u.id_perfil_usuario = 6             -- <--- FILTRA SÓ PROFESSOR
            ORDER BY p.nome_completo ASC
        `;
        const results = await querySys(sql);
        res.json(results);
    } catch (error) {
        console.error("Erro ao listar professores:", error);
        res.status(500).json({ error: "Erro ao listar professores." });
    }
});


// 5. ÁREA DO PROFESSOR (Minhas Turmas)
router.get("/professores/me/turmas", verificarUsuario, async (req, res) => {
    try {
        const userId = req.user.id; // ID do Usuário (Tabela usuario)

        // 1. Descobrir qual é o colaborador_id deste usuário
        const [user] = await querySys("SELECT id_colaborador FROM usuario WHERE id = ?", [userId]);

        if (!user) return res.status(404).json({ error: "Usuário não encontrado." });
        const colaboradorId = user.id_colaborador;

        // 2. Buscar turmas onde ele é professor (ativo) e a turma/projeto também estão ativos
        const sql = `
            SELECT t.id, t.nome, t.turno, t.periodo, t.dias_aula, p.titulo as nome_projeto
            FROM turmas t
            JOIN turma_professores tp ON t.id = tp.turma_id
            JOIN projeto p ON t.projeto_id = p.id
            WHERE tp.colaborador_id = ? 
            AND tp.ativo = 1 
            AND t.ativo = 1 
            AND p.status = 'ativo'
            ORDER BY t.created_at DESC
        `;

        const turmas = await querySys(sql, [colaboradorId]);

        // Formata os dias de aula (JSON -> Array)
        const turmasFormatadas = turmas.map(t => ({
            ...t,
            dias_aula: JSON.parse(t.dias_aula || "[]")
        }));

        res.json(turmasFormatadas);

    } catch (error) {
        console.error("Erro ao buscar minhas turmas:", error);
        res.status(500).json({ error: "Erro ao carregar suas turmas." });
    }
});

router.get("/integracao", (req, res) => {
    res.send("API DE INTEGRAÇÃO RODANDO 🚀");
});

router.get("/turmas/:id/estatisticas", verificarUsuario, async (req, res) => {
    const { id } = req.params;
    try {
        // VERIFICAÇÃO DE SEGURANÇA
        if (!(await verificarAcessoProfessorTurma(req.user.id, id))) {
            return res.status(403).json({ error: "Acesso negado." });
        }

        const sql = `
            SELECT 
                p.nome_completo,
                p.cpf,
                m.id as matricula_id,
                COUNT(f.id) as total_aulas,
                SUM(CASE WHEN f.status IN ('Presente', 'Justificado') THEN 1 ELSE 0 END) as presencas,
                SUM(CASE WHEN f.status = 'Ausente' THEN 1 ELSE 0 END) as faltas
            FROM frequencias f
            JOIN matriculas m ON f.matricula_id = m.id
            JOIN Beneficiario b ON m.beneficiario_id = b.id
            JOIN pessoa p ON b.pessoa_id = p.id
            JOIN aulas a ON f.aula_id = a.id
            WHERE a.turma_id = ?
            GROUP BY m.id
            ORDER BY presencas DESC
        `;

        const stats = await querySys(sql, [id]);

        // Calcular totais gerais da turma
        const resumo = {
            total_aulas_registradas: 0,
            total_presencas: 0,
            total_faltas: 0,
            alunos: stats.map(s => {
                const p = Number(s.presencas);
                const f = Number(s.faltas);
                const total = p + f;
                const frequencia_percent = total > 0 ? ((p / total) * 100).toFixed(1) : 0;
                return {
                    ...s,
                    presencas: p,
                    faltas: f,
                    frequencia_percent: parseFloat(frequencia_percent)
                };
            })
        };

        // Pegar total de aulas distintas dada na turma
        const sqlTotalAulas = "SELECT COUNT(*) as total FROM aulas WHERE turma_id = ?";
        const [rowsTotal] = await querySys(sqlTotalAulas, [id]);
        resumo.total_aulas_registradas = rowsTotal ? rowsTotal.total : 0;

        // Somar totais
        if (stats.length > 0) {
            stats.forEach(s => {
                resumo.total_presencas += Number(s.presencas);
                resumo.total_faltas += Number(s.faltas);
            });
        }

        res.json(resumo);

    } catch (error) {
        console.error("Erro estatisticas:", error);
        res.status(500).json({ error: "Erro ao calcular estatísticas" });
    }
});

// GET /matriculas/:id/frequencia - Histórico individual do aluno
router.get("/matriculas/:id/frequencia", verificarUsuario, async (req, res) => {
    const { id } = req.params;
    try {
        // 1. Descobrir turma da matricula para validar segurança
        const [mat] = await querySys("SELECT turma_id FROM matriculas WHERE id = ?", [id]);
        if (!mat) return res.status(404).json({ error: "Matrícula não encontrada." });

        // 2. Segurança (Professor da turma ou Coord)
        if (!(await verificarAcessoProfessorTurma(req.user.id, mat.turma_id))) {
            return res.status(403).json({ error: "Acesso negado." });
        }

        const sql = `
            SELECT a.data_aula, a.conteudo, f.status, f.observacao, p.nome_completo as professor
            FROM frequencias f
            JOIN aulas a ON f.aula_id = a.id
            JOIN colaborador c ON a.colaborador_id = c.id
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE f.matricula_id = ?
            ORDER BY a.data_aula DESC
        `;
        const historico = await querySys(sql, [id]);
        res.json(historico);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Erro ao buscar histórico do aluno." });
    }
});

module.exports = router;