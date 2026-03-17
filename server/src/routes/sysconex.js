const express = require('express');
const router = express.Router();
const { dbSysConex, querySys } = require('../config/database');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');
const multer = require('multer');

// --- Configuração de Upload ---
// Ajuste do caminho:
// __dirname = server/src/routes
// .. = server/src
// ../.. = server
// ../../.. = sistema-frequencia
// logo: path.resolve(__dirname, '../../../public_html/uploads') aponta para sistema-frequencia/public_html/uploads
const UPLOAD_PATH = path.resolve(__dirname, '../../../public_html/uploads/fotos_frequencia');

if (!fs.existsSync(UPLOAD_PATH)) {
    fs.mkdirSync(UPLOAD_PATH, { recursive: true });
}

const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, UPLOAD_PATH),
    filename: (req, file, cb) => {
        const ext = path.extname(file.originalname) || '.jpg';
        cb(null, `${uuidv4()}${ext}`);
    },
});

const upload = multer({ storage });

// --- Configuração de Upload Planos de Trabalho ---
const PLANOS_UPLOAD_PATH = path.resolve(__dirname, '../../../public_html/uploads/planos_trabalho');

if (!fs.existsSync(PLANOS_UPLOAD_PATH)) {
    fs.mkdirSync(PLANOS_UPLOAD_PATH, { recursive: true });
}

const storagePlanos = multer.diskStorage({
    destination: (req, file, cb) => cb(null, PLANOS_UPLOAD_PATH),
    filename: (req, file, cb) => {
        const ext = path.extname(file.originalname) || '.pdf';
        cb(null, `plano_${uuidv4()}${ext}`);
    },
});

const uploadPlanos = multer({
    storage: storagePlanos,
    limits: { fileSize: 2 * 1024 * 1024 }, // 2MB limit
    fileFilter: (req, file, cb) => {
        if (file.mimetype === "application/pdf") {
            cb(null, true);
        } else {
            cb(new Error("Apenas arquivos PDF são permitidos."));
        }
    }
});





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
    // 1. Busca dados do user (colaborador e perfil)
    const [user] = await querySys("SELECT id_colaborador, id_perfil_usuario FROM usuario WHERE id = ?", [usuarioId]);
    if (!user) return false;

    // 2. Descobre dados da aula (turma e autor)
    const [aula] = await querySys("SELECT turma_id, colaborador_id FROM aulas WHERE id = ?", [aulaId]);
    if (!aula) return false;

    // 3. Regra: Coordenador (não-6) pode tudo. Professor (6) só se for o autor.
    if (user.id_perfil_usuario !== 6) return true;

    // Se for professor, tem que ser o DONO da aula
    if (aula.colaborador_id !== user.id_colaborador) return false;

    return true;
}

router.post("/auth/login", async (req, res) => {

    const { login, senha } = req.body;


    // No front vamos mandar { login: 'CPF', senha: '...' }

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

            let totalCriados = 0;
            let totalAtualizadosReais = 0;

            for (const u of listaUsuarios) {
                if (!u.cpf) continue;

                const cpfLimpo = u.cpf.replace(/\D/g, '');
                let pessoaId;

                let ehNovaPessoa = false;
                let houveAlteracaoReal = false;

                const defaults = {
                    mae: u.nome_mae || "NÃO INFORMADO",
                    gen: u.genero_id || 1,
                    etn: u.etnia_id || 1,
                    apelido: u.apelido || null // Pegando o apelido aqui
                };

                // =================================  
                // 1. PESSOA (Atualizado com Apelido)
                // =================================  
                const rows = await queryTx("SELECT id FROM pessoa WHERE cpf = ?", [cpfLimpo]);

                if (rows.length > 0) {
                    pessoaId = rows[0].id;
                    const resPessoa = await queryTx(`  
                        UPDATE pessoa   
                        SET nome_completo = ?, apelido = ?, data_nasc = ?, nome_mae = ?, genero_id = ?, etnia_id = ?, status = 1  
                        WHERE id = ?  
                    `, [u.nome_completo, defaults.apelido, u.data_nasc || '2000-01-01', defaults.mae, defaults.gen, defaults.etn, pessoaId]);

                    if (resPessoa.changedRows > 0) houveAlteracaoReal = true;

                } else {
                    const resPessoa = await queryTx(`  
                        INSERT INTO pessoa   
                        (nome_completo, apelido, cpf, data_nasc, nome_mae, naturalidade, nacionalidade, genero_id, etnia_id, escolaridade_id, orgao_emissor_id, status)   
                        VALUES (?, ?, ?, ?, ?, 'BRASIL', 'BRASIL', ?, ?, 1, 1, 1)  
                    `, [u.nome_completo, defaults.apelido, cpfLimpo, u.data_nasc || '2000-01-01', defaults.mae, defaults.gen, defaults.etn]);

                    pessoaId = resPessoa.insertId;
                    ehNovaPessoa = true;
                }

                // =================================  
                // 2. CONTATO  
                // =================================  
                if (u.email) {
                    const checkContato = await queryTx("SELECT id FROM contato WHERE pessoa_id = ?", [pessoaId]);
                    if (checkContato.length > 0) {
                        const resC = await queryTx("UPDATE contato SET email = ? WHERE id = ?", [u.email, checkContato[0].id]);
                        if (resC.changedRows > 0) houveAlteracaoReal = true;
                    } else {
                        await queryTx("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                        if (!ehNovaPessoa) houveAlteracaoReal = true;
                    }
                }

                // =================================  
                // 3. BENEFICIARIO OU COLABORADOR  
                // =================================  
                if (u.tipo === "ALUNO") {
                    const checkBenef = await queryTx("SELECT id FROM Beneficiario WHERE pessoa_id = ?", [pessoaId]);
                    if (checkBenef.length > 0) {
                        const resB = await queryTx("UPDATE Beneficiario SET id_projeto = ?, id_processo_inscricao = 1 WHERE id = ?", [u.projeto_id || 1, checkBenef[0].id]);
                        if (resB.changedRows > 0) houveAlteracaoReal = true;
                    } else {
                        await queryTx("INSERT INTO Beneficiario (pessoa_id, id_projeto, id_processo_inscricao) VALUES (?, ?, 1)", [pessoaId, u.projeto_id || 1]);
                        if (!ehNovaPessoa) houveAlteracaoReal = true;
                    }
                } else {
                    const checkColab = await queryTx("SELECT id FROM colaborador WHERE pessoa_id = ?", [pessoaId]);
                    const cargoId = u.cargo_id || 6;
                    const emailInst = u.email || 'sem_email@inst.com';
                    let colabId;

                    if (checkColab.length > 0) {
                        colabId = checkColab[0].id;
                        const resCol = await queryTx("UPDATE colaborador SET cargo_id = ?, email_institucional = ?, status = 1 WHERE id = ?", [cargoId, emailInst, colabId]);
                        if (resCol.changedRows > 0) houveAlteracaoReal = true;
                    } else {
                        const resColab = await queryTx("INSERT INTO colaborador (pessoa_id, cargo_id, email_institucional, status) VALUES (?, ?, ?, 1)", [pessoaId, cargoId, emailInst]);
                        colabId = resColab.insertId;
                        if (!ehNovaPessoa) houveAlteracaoReal = true;
                    }

                    if (u.login && u.senha && u.id_perfil_usuario) {
                        const checkUser = await queryTx("SELECT id FROM usuario WHERE id_colaborador = ?", [colabId]);
                        if (checkUser.length > 0) {
                            const resU = await queryTx("UPDATE usuario SET login = ?, senha = ?, id_perfil_usuario = ?, status = 1 WHERE id = ?", [u.login, u.senha, u.id_perfil_usuario, checkUser[0].id]);
                            if (resU.changedRows > 0) houveAlteracaoReal = true;
                        } else {
                            await queryTx("INSERT INTO usuario (id_colaborador, id_perfil_usuario, login, senha, status) VALUES (?, ?, ?, ?, 1)", [colabId, u.id_perfil_usuario, u.login, u.senha]);
                            if (!ehNovaPessoa) houveAlteracaoReal = true;
                        }
                    }
                }

                if (ehNovaPessoa) {
                    totalCriados++;
                } else if (houveAlteracaoReal) {
                    totalAtualizadosReais++;
                }
            }

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));

            res.status(200).json({
                message: "Sincronização concluída!",
                resumo: {
                    novos: totalCriados,
                    atualizados_com_mudanca: totalAtualizadosReais,
                    total_processados: listaUsuarios.length
                }
            });

        } catch (error) {
            connection.rollback(() => { });
            res.status(500).json({ error: "Erro no processamento: " + error.message });
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
            SELECT t.*, p.titulo as nome_projeto,
            (SELECT COUNT(*) FROM matriculas m WHERE m.turma_id = t.id AND m.status = 'Ativo') as total_alunos,
            (SELECT COUNT(*) FROM turma_professores tp WHERE tp.turma_id = t.id AND tp.ativo = 1) as total_professores
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

// --- NOVO: DUPLICAR TURMA COM ALUNOS ---
router.post("/turmas/:id/duplicar", verificarUsuario, async (req, res) => {
    const { id: turmaOriginalId } = req.params;
    const { novoNome } = req.body;

    dbSysConex.getConnection(async (err, connection) => {
        if (err) return res.status(500).json({ error: "Erro de conexão." });

        const queryTx = (sql, params) => {
            return new Promise((resolve, reject) => {
                connection.query(sql, params, (e, r) => e ? reject(e) : resolve(r));
            });
        };

        try {
            await new Promise((resolve, reject) => connection.beginTransaction(e => e ? reject(e) : resolve()));

            // 1. Busca os dados da turma original
            const rowsTurma = await queryTx("SELECT * FROM turmas WHERE id = ?", [turmaOriginalId]);
            if (rowsTurma.length === 0) throw new Error("Turma original não encontrada.");

            const turmaOriginal = rowsTurma[0];
            const nomeNovaTurma = novoNome || `${turmaOriginal.nome} (Cópia)`;

            // 2. Cria a nova turma com os mesmos dados, mas com status Ativo(1)
            const sqlInsertTurma = `
                INSERT INTO turmas (projeto_id, nome, turno, periodo, dias_aula, data_inicio, data_fim, ativo)
                VALUES (?, ?, ?, ?, ?, ?, ?, 1)
            `;
            const paramsNovaTurma = [
                turmaOriginal.projeto_id,
                nomeNovaTurma,
                turmaOriginal.turno,
                turmaOriginal.periodo,
                turmaOriginal.dias_aula, // O banco já guarda em JSON
                turmaOriginal.data_inicio,
                turmaOriginal.data_fim
            ];

            const resNovaTurma = await queryTx(sqlInsertTurma, paramsNovaTurma);
            const novaTurmaId = resNovaTurma.insertId;

            // 3. Busca alunos ATIVOS da turma original
            const alunosAtivos = await queryTx(
                "SELECT beneficiario_id FROM matriculas WHERE turma_id = ? AND status = 'Ativo'",
                [turmaOriginalId]
            );

            // 4. Copia as matrículas para a nova turma
            let totalCopiados = 0;
            if (alunosAtivos.length > 0) {
                // Monta o INSERT múltiplo: INSERT INTO matriculas (turma_id, beneficiario_id, status) VALUES (?, ?, 'Ativo'), (?, ?, 'Ativo')...
                const values = alunosAtivos.map(a => [novaTurmaId, a.beneficiario_id, 'Ativo']);
                const sqlInsertMatriculas = "INSERT INTO matriculas (turma_id, beneficiario_id, status) VALUES ?";

                await queryTx(sqlInsertMatriculas, [values]);
                totalCopiados = alunosAtivos.length;
            }

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));

            res.status(201).json({
                message: "Turma duplicada com sucesso!",
                novaTurmaId,
                totalAlunosCopiados: totalCopiados
            });

        } catch (error) {
            connection.rollback(() => { });
            console.error("Erro ao duplicar turma:", error);
            res.status(500).json({ error: "Erro ao duplicar turma: " + error.message });
        } finally {
            connection.release();
        }
    });
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
        `;

        const sqlCount = `SELECT COUNT(*) as total FROM matriculas WHERE turma_id = ? AND status = 'Ativo'`;

        const [dados, countRes] = await Promise.all([querySys(sqlDados, [turmaId]), querySys(sqlCount, [turmaId])]);
        const total = countRes[0].total;

        res.json({ data: dados, pagination: { total, page: 1, totalPages: 1, limit: total } });
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
    const { professor_id, titulo_aula, data_aula, conteudo, lista_presenca } = req.body;

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
                "INSERT INTO aulas (turma_id, colaborador_id, titulo_aula, data_aula, conteudo, numero_aulas) VALUES (?, ?, ?, ?, ?, ?)",
                [turmaId, colaboradorId, titulo_aula || '', data_aula, conteudo, 1]
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
            SELECT a.id, a.titulo_aula, a.data_aula, a.conteudo, a.created_at,
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
                    COALESCE(SUM(CASE WHEN status = 'Presente' THEN 1 ELSE 0 END), 0) as presentes,
                    COALESCE(SUM(CASE WHEN status = 'Ausente' THEN 1 ELSE 0 END), 0) as ausentes,
                    COALESCE(SUM(CASE WHEN status = 'Justificado' THEN 1 ELSE 0 END), 0) as justificados
                FROM frequencias WHERE aula_id = ?
            `, [aula.id]);
            return { ...aula, ...resumo };
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
    const { titulo_aula, data_aula, conteudo, lista_presenca } = req.body;

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
                "UPDATE aulas SET titulo_aula = ?, data_aula = ?, conteudo = ? WHERE id = ?",
                [titulo_aula || '', data_aula, conteudo, id]
            );

            // 2. Atualizar frequências
            // Estratégia: Iterar e fazer UPDATE individual. Se não existir, faz INSERT (caso aluno novo tenha entrado na turma, por exemplo)
            // Para simplificar, vamos assumir que a lista vem completa.
            if (lista_presenca && Array.isArray(lista_presenca)) {
                for (const reg of lista_presenca) {
                    // Tenta atualizar
                    // 1. Verifica se já existe
                    const [exists] = await queryTx(
                        "SELECT id FROM frequencias WHERE aula_id = ? AND matricula_id = ?",
                        [id, reg.matricula_id]
                    );

                    if (exists) {
                        // UPDATE
                        await queryTx(
                            "UPDATE frequencias SET status = ?, observacao = ? WHERE id = ?",
                            [reg.status, reg.observacao || null, exists.id]
                        );
                    } else {
                        // INSERT
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
        const [turmasAtivas] = await querySys(`
            SELECT COUNT(*) as total 
            FROM turmas t
            JOIN projeto p ON t.projeto_id = p.id
            WHERE t.ativo = 1 AND p.status = 'ativo'
        `);
        const [turmasEncerradas] = await querySys(`
            SELECT COUNT(*) as total 
            FROM turmas t
            JOIN projeto p ON t.projeto_id = p.id
            WHERE t.ativo = 0 OR p.status != 'ativo'
        `);
        const [alunosAtivos] = await querySys(`
            SELECT COUNT(*) as total FROM Beneficiario
        `);
        const [profsVinculados] = await querySys(`
            SELECT COUNT(*) as total 
            FROM usuario 
            WHERE id_perfil_usuario = 6 AND status = 1
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
            SELECT c.id, p.nome_completo, p.cpf, c.email_institucional, u.id as usuario_id,
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
            ORDER BY p.nome_completo ASC
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

// ROTA TEMPORÁRIA DE LIMPEZA
router.get("/debug/clean-duplicates", async (req, res) => {
    try {
        // 1. Duplicatas de Frequencia
        const sqlFreq = `
            SELECT aula_id, matricula_id, COUNT(*) as qtd 
            FROM frequencias 
            GROUP BY aula_id, matricula_id 
            HAVING qtd > 1
        `;
        const duplicatesFreq = await querySys(sqlFreq);

        // 2. Duplicatas de Matricula (Aluno duplicado na turma)
        // Isso causaria "2 alunos com mesmo nome" na chamada, explicaria contagem dobrada se ambos tiverem presença
        const sqlMat = `
            SELECT turma_id, beneficiario_id, COUNT(*) as qtd
            FROM matriculas
            WHERE status = 'Ativo'
            GROUP BY turma_id, beneficiario_id
            HAVING qtd > 1
        `;
        const duplicatesMat = await querySys(sqlMat);

        // 3. Frequencias de fantasmas (Alunos Desistentes/Inativos que ainda constam na chamada)
        const sqlGhosts = `
            SELECT f.aula_id, f.matricula_id, f.status as status_frequencia, m.status as status_matricula, p.nome_completo
            FROM frequencias f
            JOIN matriculas m ON f.matricula_id = m.id
            JOIN Beneficiario b ON m.beneficiario_id = b.id
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE m.status != 'Ativo'
        `;
        const ghosts = await querySys(sqlGhosts);

        res.json({
            message: "Diagnóstico Completo",
            freq_duplicates: duplicatesFreq,
            matricula_duplicates: duplicatesMat,
            ghost_records: ghosts
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 6. RELATÓRIOS E BUSCA (COORDENAÇÃO)

// Busca de Beneficiários (Ativos ou Inativos)
router.get("/beneficiarios/search", verificarUsuario, async (req, res) => {
    try {
        const { q } = req.query;
        if (!q || q.length < 3) return res.json([]);

        const term = `%${q}%`;
        const sql = `
            SELECT b.id, p.nome_completo, p.cpf
            FROM Beneficiario b
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE p.nome_completo LIKE ? OR p.cpf LIKE ?
            LIMIT 20
        `;
        const results = await querySys(sql, [term, term]);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Histórico Completo do Beneficiário
router.get("/beneficiarios/:id/historico", verificarUsuario, async (req, res) => {
    const { id } = req.params; // ID do Beneficiario
    try {
        // 1. Dados Pessoais
        const sqlBenef = `
            SELECT b.id, p.nome_completo, p.cpf, p.data_nasc as data_nascimento, 
                   ct.email, ct.celular as telefone_celular
            FROM Beneficiario b
            JOIN pessoa p ON b.pessoa_id = p.id
            LEFT JOIN contato ct ON ct.pessoa_id = p.id
            WHERE b.id = ?
        `;
        const [beneficiario] = await querySys(sqlBenef, [id]);
        if (!beneficiario) return res.status(404).json({ error: "Beneficiário não encontrado" });

        // 2. Histórico de Matrículas (Turmas que participou)
        const sqlMatriculas = `
            SELECT m.id as matricula_id, m.data_matricula, m.status as status_matricula,
                   t.nome as turma_nome, t.periodo, t.turno, p.titulo as projeto_nome
            FROM matriculas m
            JOIN turmas t ON m.turma_id = t.id
            JOIN projeto p ON t.projeto_id = p.id
            WHERE m.beneficiario_id = ?
            ORDER BY m.data_matricula DESC
        `;
        const matriculas = await querySys(sqlMatriculas, [id]);

        // 3. Histórico de Frequência (Unificado)
        // Precisamos pegar de TODAS as matrículas desse beneficiário
        const sqlFreq = `
            SELECT 
                f.status, f.observacao, 
                a.titulo_aula, a.data_aula, a.conteudo,
                t.nome as turma_nome,
                p.titulo as projeto_nome
            FROM frequencias f
            JOIN matriculas m ON f.matricula_id = m.id
            JOIN aulas a ON f.aula_id = a.id
            JOIN turmas t ON a.turma_id = t.id
            JOIN projeto p ON t.projeto_id = p.id
            WHERE m.beneficiario_id = ?
            ORDER BY a.data_aula DESC
        `;
        const frequencia = await querySys(sqlFreq, [id]);

        // Resumo estatístico geral
        const totalAulas = frequencia.length;
        const totalPresencas = frequencia.filter(f => f.status === 'Presente').length;
        const totalFaltas = frequencia.filter(f => f.status === 'Ausente').length;
        const totalJustificadas = frequencia.filter(f => f.status === 'Justificado').length;

        // Formatar %
        const percentual = totalAulas > 0 ? ((totalPresencas / totalAulas) * 100).toFixed(1) : 0;

        res.json({
            beneficiario,
            matriculas,
            frequencia,
            resumo: {
                total_aulas: totalAulas,
                total_presencas: totalPresencas,
                total_faltas: totalFaltas,
                total_justificadas: totalJustificadas,
                percentual_geral: percentual
            }
        });

    } catch (error) {
        console.error("Erro historico geral:", error);
        res.status(500).json({ error: "Erro ao buscar histórico." });
    }
});

// ==========================================
// 📸 GESTÃO DE FOTOS DA AULA
// ==========================================

// 1. UPLOAD DE FOTO
router.post("/aulas/:id/fotos", verificarUsuario, upload.single('foto'), async (req, res) => {
    const { id: aulaId } = req.params;

    // Se houve erro no multer ou não veio arquivo
    if (!req.file) {
        return res.status(400).json({ error: "Nenhum arquivo enviado." });
    }

    try {
        const caminhoRelativo = `/uploads/fotos_frequencia/${req.file.filename}`;
        // O user pediu para salvar em ../../../public_html/uploads.
        // O express.static no index.js está servindo '/uploads' apontando para essa pasta.
        // Então o link web será SEU_DOMINIO/uploads/nome_arquivo.

        const sql = "INSERT INTO fotos_aula (aula_id, caminho_foto) VALUES (?, ?)";
        const result = await querySys(sql, [aulaId, caminhoRelativo]);

        res.status(201).json({
            message: "Foto enviada com sucesso!",
            id: result.insertId,
            caminho: caminhoRelativo
        });

    } catch (error) {
        // Se der erro no banco, vamos apagar a foto que acabou de subir pra não ficar lixo?
        // Boa prática.
        if (req.file && req.file.path) {
            fs.unlink(req.file.path, (err) => {
                if (err) console.error("Erro ao apagar arquivo orfão:", err);
            });
        }
        console.error("Erro upload foto:", error);
        res.status(500).json({ error: "Erro ao salvar foto no banco." });
    }
});

// 2. LISTAR FOTOS DA AULA
router.get("/aulas/:id/fotos", verificarUsuario, async (req, res) => {
    try {
        const fotos = await querySys("SELECT * FROM fotos_aula WHERE aula_id = ?", [req.params.id]);
        res.json(fotos);
    } catch (error) {
        res.status(500).json({ error: "Erro ao buscar fotos." });
    }
});

// 3. DELETAR FOTO
router.delete("/fotos/:id", verificarUsuario, async (req, res) => {
    const { id } = req.params;

    try {
        // 1. Pega o caminho do arquivo antes de deletar do banco
        const [foto] = await querySys("SELECT caminho_foto FROM fotos_aula WHERE id = ?", [id]);

        if (!foto) {
            return res.status(404).json({ error: "Foto não encontrada." });
        }

        // 2. Deleta do Banco
        await querySys("DELETE FROM fotos_aula WHERE id = ?", [id]);

        // 3. Deleta arquivo físico
        // O caminho salvo no banco é algo como "/uploads/uuid.jpg"
        // Precisamos converter isso para o caminho absoluto do sistema de arquivos
        const nomeArquivo = path.basename(foto.caminho_foto);
        const caminhoArquivo = path.join(UPLOAD_PATH, nomeArquivo);

        fs.unlink(caminhoArquivo, (err) => {
            if (err && err.code !== 'ENOENT') {
                console.error(`Erro ao deletar arquivo físico ${caminhoArquivo}:`, err);
                // Não vamos retornar erro 500 aqui porque o registro do banco já foi apagado,
                // então pro usuário a operação "deu certo" (a foto sumiu do sistema).
            }
        });

        res.json({ message: "Foto excluída com sucesso!" });

    } catch (error) {
        console.error("Erro ao deletar foto:", error);
        res.status(500).json({ error: "Erro ao deletar foto." });
    }
});

// ==========================================
// 📝 GESTÃO DE PLANO DE TRABALHO
// ==========================================

// 1. UPLOAD DE PLANO DE TRABALHO E RELATÓRIO MENSAL
router.post("/plano-trabalho", verificarUsuario, (req, res, next) => {
    uploadPlanos.fields([
        { name: 'planejamento', maxCount: 1 },
        { name: 'relatorio', maxCount: 1 }
    ])(req, res, function (err) {
        if (err instanceof multer.MulterError) {
            // Um erro do Multer ocorreu durante o upload.
            if (err.code === 'LIMIT_FILE_SIZE') {
                return res.status(400).json({ error: "O arquivo excede o limite máximo permitido de 2MB." });
            }
            return res.status(400).json({ error: `Erro no upload: ${err.message}` });
        } else if (err) {
            // Um erro desconhecido ocorreu, ou erro customizado do fileFilter
            return res.status(400).json({ error: err.message });
        }
        // Deu tudo certo, passa pro próximo middleware
        next();
    });
}, async (req, res) => {
    try {
        const { ano, mes } = req.body;
        const usuarioId = req.user.id;

        if (!ano || !mes) {
            return res.status(400).json({ error: "Ano e mês são obrigatórios." });
        }

        // Pega os caminhos dos arquivos se existirem
        let caminhoPlanejamento = null;
        let caminhoRelatorio = null;

        if (req.files['planejamento'] && req.files['planejamento'].length > 0) {
            caminhoPlanejamento = `/uploads/planos_trabalho/${req.files['planejamento'][0].filename}`;
        }

        if (req.files['relatorio'] && req.files['relatorio'].length > 0) {
            caminhoRelatorio = `/uploads/planos_trabalho/${req.files['relatorio'][0].filename}`;
        }

        if (!caminhoPlanejamento && !caminhoRelatorio) {
            return res.status(400).json({ error: "Nenhum arquivo enviado." });
        }

        // Verifica se já existe registro para esse usuário, ano e mês
        const [existe] = await querySys(
            "SELECT id, caminho_planejamento, caminho_relatorio FROM plano_trabalho WHERE usuario_id = ? AND ano = ? AND mes = ?",
            [usuarioId, ano, mes]
        );

        if (existe) {
            // Update
            const novoPlanejamento = caminhoPlanejamento || existe.caminho_planejamento;
            const novoRelatorio = caminhoRelatorio || existe.caminho_relatorio;

            await querySys(
                "UPDATE plano_trabalho SET caminho_planejamento = ?, caminho_relatorio = ? WHERE id = ?",
                [novoPlanejamento, novoRelatorio, existe.id]
            );

            // Deleta arquivos físicos antigos se foram substituídos
            if (caminhoPlanejamento && existe.caminho_planejamento) {
                const velhoPlan = path.join(PLANOS_UPLOAD_PATH, path.basename(existe.caminho_planejamento));
                fs.unlink(velhoPlan, () => { });
            }
            if (caminhoRelatorio && existe.caminho_relatorio) {
                const velhoRel = path.join(PLANOS_UPLOAD_PATH, path.basename(existe.caminho_relatorio));
                fs.unlink(velhoRel, () => { });
            }

            return res.json({ message: "Plano de trabalho atualizado com sucesso!" });
        } else {
            // Insert
            await querySys(
                "INSERT INTO plano_trabalho (usuario_id, ano, mes, caminho_planejamento, caminho_relatorio) VALUES (?, ?, ?, ?, ?)",
                [usuarioId, ano, mes, caminhoPlanejamento, caminhoRelatorio]
            );
            return res.status(201).json({ message: "Plano de trabalho salvo com sucesso!" });
        }
    } catch (error) {
        console.error("Erro upload plano de trabalho:", error);
        res.status(500).json({ error: "Erro ao salvar o plano de trabalho no banco." });
    }
});

// 2. LISTAR PLANOS DE TRABALHO DO PROFESSOR
router.get("/plano-trabalho", verificarUsuario, async (req, res) => {
    try {
        const usuarioId = req.user.id;
        const planos = await querySys(
            "SELECT * FROM plano_trabalho WHERE usuario_id = ? ORDER BY ano DESC, mes DESC",
            [usuarioId]
        );
        res.json(planos);
    } catch (error) {
        res.status(500).json({ error: "Erro ao buscar os planos de trabalho." });
    }
});

// 3. LISTAR PLANOS DE TRABALHO DE UM USUÁRIO (COORDENADOR)
router.get("/plano-trabalho/usuario/:usuarioId/detalhes", verificarUsuario, async (req, res) => {
    try {
        const { usuarioId } = req.params;
        const planos = await querySys(
            "SELECT * FROM plano_trabalho WHERE usuario_id = ? ORDER BY ano DESC, mes DESC",
            [usuarioId]
        );

        const [user] = await querySys(`
            SELECT p.nome_completo
            FROM usuario u
            JOIN colaborador c ON u.id_colaborador = c.id
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE u.id = ?
        `, [usuarioId]);

        res.json({
            planos,
            professorNome: user ? user.nome_completo : "Professor"
        });
    } catch (error) {
        res.status(500).json({ error: "Erro ao buscar os planos de trabalho." });
    }
});

// 4. DELETAR PLANO DE TRABALHO (PROFESSOR)
router.delete("/plano-trabalho/:id", verificarUsuario, async (req, res) => {
    try {
        const { id } = req.params;
        const usuarioId = req.user.id;

        // 1. Verifica se o plano existe e pertence ao professor
        const [plano] = await querySys(
            "SELECT id, caminho_planejamento, caminho_relatorio, feedback_coordenador FROM plano_trabalho WHERE id = ? AND usuario_id = ?",
            [id, usuarioId]
        );

        if (!plano) {
            return res.status(404).json({ error: "Plano de trabalho não encontrado." });
        }

        // 2. Verifica se já existe feedback
        if (plano.feedback_coordenador && plano.feedback_coordenador.trim() !== "") {
            return res.status(403).json({ error: "Não é possível excluir um plano que já possui feedback da coordenação." });
        }

        // 3. Deleta os arquivos físicos
        if (plano.caminho_planejamento) {
            const planPath = path.join(PLANOS_UPLOAD_PATH, path.basename(plano.caminho_planejamento));
            fs.unlink(planPath, () => { });
        }
        if (plano.caminho_relatorio) {
            const relPath = path.join(PLANOS_UPLOAD_PATH, path.basename(plano.caminho_relatorio));
            fs.unlink(relPath, () => { });
        }

        // 4. Deleta do banco
        await querySys("DELETE FROM plano_trabalho WHERE id = ?", [id]);

        res.json({ message: "Plano de trabalho excluído com sucesso." });
    } catch (error) {
        console.error("Erro ao excluir plano de trabalho:", error);
        res.status(500).json({ error: "Erro ao excluir o plano de trabalho." });
    }
});

// ==========================================
// 🔍 MONITORAMENTO DE PROFESSORES (COORDENAÇÃO)
// ==========================================

// 1. Obter Planos de Trabalho de um Professor no Mês
router.get("/monitoramento/planos/:usuarioId/:ano/:mes", verificarUsuario, async (req, res) => {
    try {
        const { usuarioId, ano, mes } = req.params;
        const sql = `
            SELECT id, caminho_planejamento, caminho_relatorio, feedback_coordenador
            FROM plano_trabalho
            WHERE usuario_id = ? AND ano = ? AND mes = ?
        `;
        const results = await querySys(sql, [usuarioId, ano, mes]);
        // Retorna o primeiro já que é unique key, ou null se não houver
        res.json(results.length > 0 ? results[0] : null);
    } catch (error) {
        console.error("Erro ao buscar planos no monitoramento:", error);
        res.status(500).json({ error: "Erro ao buscar planos de trabalho." });
    }
});

// 2. Salvar Feedback do Coordenador no Plano de Trabalho
router.put("/monitoramento/planos/:id/feedback", verificarUsuario, async (req, res) => {
    try {
        const { id } = req.params;
        const { feedback } = req.body;

        const sql = `UPDATE plano_trabalho SET feedback_coordenador = ? WHERE id = ?`;
        await querySys(sql, [feedback, id]);

        res.json({ message: "Feedback salvo com sucesso." });
    } catch (error) {
        console.error("Erro ao salvar feedback:", error);
        res.status(500).json({ error: "Erro ao salvar feedback." });
    }
});

// 3. Obter Relatório de Aulas e Fotos de um Professor no Mês
router.get("/monitoramento/aulas/:colaboradorId/:ano/:mes", verificarUsuario, async (req, res) => {
    try {
        const { colaboradorId, ano, mes } = req.params;

        // 1. Buscar todas as aulas do colaborador no mês/ano
        const sqlAulas = `
            SELECT a.id, a.titulo_aula, a.data_aula, a.conteudo, t.nome as turma_nome
            FROM aulas a
            JOIN turmas t ON a.turma_id = t.id
            WHERE a.colaborador_id = ? 
              AND YEAR(a.data_aula) = ? 
              AND MONTH(a.data_aula) = ?
            ORDER BY a.data_aula ASC
        `;
        const aulas = await querySys(sqlAulas, [colaboradorId, ano, mes]);

        // 2. Para cada aula, buscar as fotos anexadas (como em getFotosAula)
        for (let aula of aulas) {
            const fotos = await querySys(`SELECT * FROM fotos_aula WHERE aula_id = ? ORDER BY created_at ASC`, [aula.id]);
            aula.fotos = fotos || [];
        }

        res.json(aulas);
    } catch (error) {
        console.error("Erro ao buscar aulas no monitoramento:", error);
        res.status(500).json({ error: "Erro ao buscar histórico de aulas do professor." });
    }
});
router.get("/professores/:usuarioId/turmas", verificarUsuario, async (req, res) => {
    try {
        const { usuarioId } = req.params;
        
        // 1. Acha o colaboradorId usando o usuarioId
        const [user] = await querySys("SELECT id_colaborador FROM usuario WHERE id = ?", [usuarioId]);
        if (!user || !user.id_colaborador) {
             return res.json([]);
        }

        // 2. Busca as turmas atreladas ao colaborador na tabela de vínculo + JOIN projeto
        const sql = `
            SELECT t.*, 
                   p.titulo as nome_projeto
            FROM turmas t
            JOIN turma_professores tp ON t.id = tp.turma_id
            LEFT JOIN projeto p ON t.projeto_id = p.id
            WHERE tp.colaborador_id = ? AND tp.ativo = 1
            ORDER BY t.nome ASC
        `;
        const turmas = await querySys(sql, [user.id_colaborador]);
        
        // Formata os tipos caso venham string
        const turmasFormatadas = Array.isArray(turmas) ? turmas.map(t => ({
             ...t,
             ativo: t.ativo === 1 || t.ativo === '1' || t.ativo === true
        })) : [];

        res.json(turmasFormatadas);
    } catch (error) {
        console.error("Erro ao buscar turmas do professor:", error);
        res.status(500).json({ error: "Erro ao buscar turmas" });
    }
});

module.exports = router;