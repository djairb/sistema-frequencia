const express = require('express');
const cors = require('cors');
const mysql = require('mysql');
require('dotenv').config();

const app = express();

// Configurações Básicas
app.use(cors());
app.use(express.json());

// --- CONEXÃO COM O BANCO NOVO ---
const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "Karolinne10", // Sua senha
    database: "sysfrequenciaBeneficiario" // Banco Novo
});

// Helper para Async/Await
const query = (sql, params) => {
    return new Promise((resolve, reject) => {
        db.query(sql, params, (err, result) => {
            if (err) reject(err);
            else resolve(result);
        });
    });
};

// Teste de conexão
db.getConnection((err, connection) => {
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
app.get("/turmas", async (req, res) => {
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
app.post("/turmas", async (req, res) => {
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
app.get("/turmas/:id", async (req, res) => {
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
app.post("/turmas/:id/matriculas", async (req, res) => {
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
app.get("/turmas/:id/matriculas", async (req, res) => {
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
app.post("/turmas/:id/professores", async (req, res) => {
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
app.get("/turmas/:id/professores", async (req, res) => {
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
app.get("/professores/:id/turmas", async (req, res) => {
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
app.post("/turmas/:id/aulas", async (req, res) => {
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
// Caso o Rhian queira mandar dados via POST no futuro
app.post("/api/integracao/receber-usuarios", async (req, res) => {
    // Implementação futura conforme necessidade
    res.status(200).json({ message: "Endpoint pronto para receber dados." });
});

// --- INICIALIZAÇÃO ---
const PORT = 10000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor SysFrequencia (Banco Novo) rodando na porta ${PORT}`);
});