const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();

// Configurações Básicas
app.use(cors());
app.use(express.json());

// --- CONEXÃO COM O BANCO NOVO ---
const dbFreqBeneficiario = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "Karolinne10", // Sua senha
    database: "somosc28_frequenciaBeneficiario" // Banco Novo
});

// Helper para Async/Await
const query = (sql, params) => {
    return new Promise((resolve, reject) => {
        dbFreqBeneficiario.query(sql, params, (err, result) => {
            if (err) reject(err);
            else resolve(result);
        });
    });
};

// Teste de conexão
dbFreqBeneficiario.getConnection((err, connection) => {
    if (err) {
        console.error("❌ Erro ao conectar no MySQL:", err.code);
    } else {
        console.log("✅ Conectado ao MySQL (sysfrequenciaBeneficiario) com sucesso!");
        connection.release();
    }
});

// ==========================================
//                 ROTAS
// ==========================================

// --- 1. CRUD DE TURMAS ---

// Listar todas as turmas
app.get("/sysconex-freq/turmas", async (req, res) => {
    try {
        const results = await query("SELECT * FROM turmas ORDER BY id DESC");
        
        const turmasFormatadas = results.map(t => ({
            ...t,
            dias_aula: JSON.parse(t.dias_aula || "[]"),
            ativo: t.ativo === 1
        }));
        
        res.json(turmasFormatadas);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Erro ao buscar turmas" });
    }
});

// Criar nova turma
app.post("/sysconex-freq/turmas", async (req, res) => {
    const { projeto_id, nome, turno, periodo, dias_aula, data_inicio, data_fim } = req.body;

    try {
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
            JSON.stringify(dias_aula || []), 
            data_inicio, 
            data_fim
        ];

        const result = await query(sql, values);
        
        res.status(201).json({ 
            message: "Turma criada com sucesso!", 
            id: result.insertId 
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Erro ao criar turma" });
    }
});

// Pegar UMA turma pelo ID
app.get("/sysconex-freq/turmas/:id", async (req, res) => {
    try {
        const results = await query("SELECT * FROM turmas WHERE id = ?", [req.params.id]);
        
        if (results.length === 0) {
            return res.status(404).json({ error: "Turma não encontrada" });
        }
        
        const turma = results[0];
        turma.dias_aula = JSON.parse(turma.dias_aula || "[]");
        turma.ativo = turma.ativo === 1;
        
        res.json(turma); 
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- 2. GESTÃO DE MATRÍCULAS (ATUALIZADO PARA BENEFICIARIO) ---

// Matricular Aluno (Usa 'beneficiario_id' agora)
app.post("/sysconex-freq/turmas/:id/matriculas", async (req, res) => {
    const { id: turmaId } = req.params;
    const { aluno_id } = req.body; // No front a gente manda 'aluno_id', mas aqui tratamos como 'beneficiario_id'

    try {
        // Validação de Projeto (Mantida)
        const [turmaAlvo] = await query("SELECT projeto_id FROM turmas WHERE id = ?", [turmaId]);
        if (!turmaAlvo) return res.status(404).json({ error: "Turma não encontrada" });

        // Insere na tabela nova usando 'beneficiario_id'
        await query(
            "INSERT INTO matriculas (turma_id, beneficiario_id, status) VALUES (?, ?, 'Ativo')", 
            [turmaId, aluno_id]
        );

        res.status(201).json({ message: "Aluno matriculado com sucesso!" });

    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: "Aluno já está matriculado nesta turma." });
        }
        res.status(500).json({ error: error.message });
    }
});

// Listar Alunos da Turma (COM JOIN NA TABELA PESSOA - Traz o nome!)
app.get("/sysconex-freq/turmas/:id/matriculas", async (req, res) => {
    try {
        const { id } = req.params;
        
        // O PULO DO GATO: JOIN para pegar o Nome do Aluno na tabela Pessoa
        const sql = `
            SELECT 
                m.id, 
                m.turma_id, 
                m.beneficiario_id as aluno_id, 
                m.status,
                p.nome_completo as nome, -- Traz o nome direto!
                p.cpf
            FROM matriculas m
            JOIN Beneficiario b ON m.beneficiario_id = b.id
            JOIN pessoa p ON b.pessoa_id = p.id
            WHERE m.turma_id = ?
        `;
        const results = await query(sql, [id]);
        
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- 3. GESTÃO DE PROFESSORES (ATUALIZADO PARA COLABORADOR) ---

// Vincular Professor (Usa 'colaborador_id')
app.post("/sysconex-freq/turmas/:id/professores", async (req, res) => {
    const { id: turmaId } = req.params;
    const { professor_id } = req.body; // Front manda 'professor_id', Back usa 'colaborador_id'

    try {
        await query(
            "INSERT INTO turma_professores (turma_id, colaborador_id) VALUES (?, ?)", 
            [turmaId, professor_id]
        );
        res.status(201).json({ message: "Professor vinculado com sucesso!" });
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: "Professor já está vinculado." });
        }
        res.status(500).json({ error: error.message });
    }
});

// Listar Professores da Turma (COM JOIN - Traz nome e email)
app.get("/sysconex-freq/turmas/:id/professores", async (req, res) => {
    try {
        const sql = `
            SELECT 
                tp.id, 
                tp.colaborador_id as professor_id, 
                p.nome_completo as nome,
                c.email_institucional as email
            FROM turma_professores tp
            JOIN colaborador c ON tp.colaborador_id = c.id
            JOIN pessoa p ON c.pessoa_id = p.id
            WHERE tp.turma_id = ?
        `;
        const results = await query(sql, [req.params.id]);
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- 4. ÁREA DO PROFESSOR (MINHAS TURMAS) ---

// Listar Turmas do Professor Logado
app.get("/sysconex-freq/professores/:id/turmas", async (req, res) => {
    try {
        const { id } = req.params; // ID do USUÁRIO logado
        
        // Lógica: Usuário -> Colaborador -> Turma
        const sql = `
            SELECT t.* FROM turmas t
            JOIN turma_professores tp ON t.id = tp.turma_id
            JOIN usuario u ON u.id_colaborador = tp.colaborador_id
            WHERE u.id = ?
        `;
        const results = await query(sql, [id]);
        
        const turmasFormatadas = results.map(t => ({
            ...t,
            dias_aula: JSON.parse(t.dias_aula || "[]"),
            ativo: t.ativo === 1
        }));

        res.json(turmasFormatadas);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- 5. REGISTRO DE AULA E CHAMADA ---
app.post("/sysconex-freq/turmas/:id/aulas", async (req, res) => {
    const { id: turmaId } = req.params;
    const { professor_id, data_aula, conteudo, lista_presenca } = req.body; // professor_id aqui é o ID do usuário logado

    try {
        // Primeiro, precisamos descobrir o ID do Colaborador baseado no ID do Usuário
        const [user] = await query("SELECT id_colaborador FROM usuario WHERE id = ?", [professor_id]);
        if (!user) return res.status(404).json({ error: "Usuário não encontrado" });
        
        const idColaborador = user.id_colaborador;

        // 1. Cria a AULA
        const sqlAula = `
            INSERT INTO aulas (turma_id, colaborador_id, data_aula, conteudo, numero_aulas) 
            VALUES (?, ?, ?, ?, 1)
        `;
        const resultAula = await query(sqlAula, [turmaId, idColaborador, data_aula, conteudo]);
        const aulaId = resultAula.insertId;

        // 2. Salva as FREQUÊNCIAS
        if (lista_presenca && lista_presenca.length > 0) {
            const values = lista_presenca.map(item => [
                aulaId, 
                item.matricula_id, 
                item.status
            ]);
            
            const sqlFreq = "INSERT INTO frequencias (aula_id, matricula_id, status) VALUES ?";
            await query(sqlFreq, [values]);
        }

        res.status(201).json({ message: "Aula registrada com sucesso!", aulaId });

    } catch (error) {
        console.error("Erro ao registrar aula:", error);
        res.status(500).json({ error: error.message });
    }
});

// --- 6. WEBHOOK DE INTEGRAÇÃO (BÔNUS) ---
// ========================================================
// 🔄 ROTA DE INTEGRAÇÃO (WEBHOOK) - RECEBE DADOS DO RHIAN
// ========================================================
// ========================================================
// 🔄 ROTA DE INTEGRAÇÃO CORRIGIDA (COM TABELA CONTATO)
// ========================================================
app.post("/api/sysconex-freq/integracao/receber-dados", async (req, res) => {
    const listaUsuarios = req.body;

    if (!Array.isArray(listaUsuarios)) {
        return res.status(400).json({ error: "O corpo deve ser uma lista JSON." });
    }

    const connection = await dbFreqBeneficiario.getConnection();

    try {
        await connection.beginTransaction();

        let criados = 0;
        let atualizados = 0;

        for (const u of listaUsuarios) {
            if (!u.cpf) continue; 
            const cpfLimpo = u.cpf.replace(/\D/g, '');

            // Busca Pessoa
            const [rows] = await connection.query("SELECT id FROM pessoa WHERE cpf = ?", [cpfLimpo]);
            let pessoaId;

            // Defaults
            const defaults = {
                mae: u.nome_mae || "NÃO INFORMADO",
                gen: u.genero_id || 1,
                etn: u.etnia_id || 1
            };

            if (rows.length > 0) {
                // --- ATUALIZAR (UPDATE) ---
                pessoaId = rows[0].id;
                // Atualiza Nome (Sem email na tabela pessoa)
                await connection.query("UPDATE pessoa SET nome_completo = ? WHERE id = ?", [u.nome_completo, pessoaId]);
                
                // Atualiza Email na tabela CONTATO
                const [checkContato] = await connection.query("SELECT id FROM contato WHERE pessoa_id = ?", [pessoaId]);
                if (checkContato.length > 0) {
                    await connection.query("UPDATE contato SET email = ? WHERE id = ?", [u.email, checkContato[0].id]);
                } else {
                    await connection.query("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                }
                atualizados++;
            } else {
                // --- CRIAR NOVO (INSERT) ---
                const sqlInsert = `
                    INSERT INTO pessoa (nome_completo, cpf, data_nasc, nome_mae, naturalidade, nacionalidade, genero_id, etnia_id, escolaridade_id, orgao_emissor_id) 
                    VALUES (?, ?, ?, ?, 'BRASIL', 'BRASIL', ?, ?, 1, 1)
                `;
                const [resPessoa] = await connection.query(sqlInsert, [
                    u.nome_completo, cpfLimpo, u.data_nasc || '2000-01-01', defaults.mae, defaults.gen, defaults.etn
                ]);
                pessoaId = resPessoa.insertId;

                // Salva Email no CONTATO
                if (u.email) {
                    await connection.query("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                }
                criados++;
            }

            // Lógica ALUNO
            if (u.tipo === "ALUNO") {
                const [checkBenef] = await connection.query("SELECT id FROM Beneficiario WHERE pessoa_id = ?", [pessoaId]);
                if (checkBenef.length === 0) {
                    await connection.query("INSERT INTO Beneficiario (pessoa_id, id_projeto, id_processo_inscricao) VALUES (?, ?, 1)", [pessoaId, u.projeto_id || 1]);
                }
            } 
            // Lógica PROFESSOR
            else if (u.tipo === "PROFESSOR") {
                const [checkColab] = await connection.query("SELECT id FROM colaborador WHERE pessoa_id = ?", [pessoaId]);
                let colabId;
                if (checkColab.length === 0) {
                    const [resColab] = await connection.query("INSERT INTO colaborador (pessoa_id, cargo_id, email_institucional) VALUES (?, ?, ?)", [pessoaId, u.cargo_id || 6, u.email || 'sem_email@inst.com']);
                    colabId = resColab.insertId;
                } else {
                    colabId = checkColab[0].id;
                }
                
                const [checkUser] = await connection.query("SELECT id FROM usuario WHERE id_colaborador = ?", [colabId]);
                if (checkUser.length === 0) {
                    await connection.query(
                        "INSERT INTO usuario (id_colaborador, id_perfil_usuario, login, senha, status) VALUES (?, 6, ?, '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1)",
                        [colabId, cpfLimpo]
                    );
                }
            }
        }

        await connection.commit();
        res.status(200).json({ message: "Sincronização realizada!", resumo: { criados, atualizados } });

    } catch (error) {
        await connection.rollback();
        console.error("Erro Webhook:", error);
        res.status(500).json({ error: "Erro: " + error.message });
    } finally {
        connection.release();
    }
});

app.get("/api/sysconex-freq", (req, res) => {
  res.send("API DE INTEGRAÇÃO RODANDO uguuu")
});

// --- INICIALIZAÇÃO ---
const PORT = 10000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor SysFrequencia (Banco Novo) rodando na porta ${PORT}`);
});