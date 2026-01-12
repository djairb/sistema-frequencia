const express = require('express');
const cors = require('cors');
const mysql = require('mysql');
require('dotenv').config();

const app = express();

// Configurações Básicas
app.use(cors());
app.use(express.json());

// --- CONEXÃO COM O BANCO ---
const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "Karolinne10", // Sua senha
    database: "sysfrequencia" // Nome atualizado
});

// Helper para usar Async/Await no MySQL (Facilita muito a vida!)
const query = (sql, params) => {
    return new Promise((resolve, reject) => {
        db.query(sql, params, (err, result) => {
            if (err) reject(err);
            else resolve(result);
        });
    });
};

// Teste de conexão ao iniciar
db.getConnection((err, connection) => {
    if (err) {
        console.error("❌ Erro ao conectar no MySQL:", err.code);
    } else {
        console.log("✅ Conectado ao MySQL (sysfrequencia) com sucesso!");
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
        
        // Converte o JSON string de dias_aula volta para Array
        const turmasFormatadas = results.map(t => ({
            ...t,
            dias_aula: JSON.parse(t.dias_aula || "[]"),
            ativo: t.ativo === 1 // Garante booleano
        }));
        
        res.json(turmasFormatadas);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Erro ao buscar turmas" });
    }
});

// Criar nova turma
app.post("/turmas", async (req, res) => {
    // projeto_id vem do frontend (selecionado no select de Projetos Mock)
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
            JSON.stringify(dias_aula || []), // Salva como string JSON
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

// --- 2. GESTÃO DE MATRÍCULAS (Com Trava de Projeto) ---

// --- NOVO: PEGAR UMA TURMA ESPECÍFICA ---
// Rota para pegar UMA turma pelo ID
app.get("/turmas/:id", async (req, res) => {
    try {
        const results = await query("SELECT * FROM turmas WHERE id = ?", [req.params.id]);
        
        // Se não achar nada, retorna 404
        if (results.length === 0) {
            return res.status(404).json({ error: "Turma não encontrada" });
        }
        
        const turma = results[0];
        
        // Formatação
        turma.dias_aula = JSON.parse(turma.dias_aula || "[]");
        turma.ativo = turma.ativo === 1;
        
        // RETORNA O OBJETO DIRETO
        res.json(turma); 
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- NOVO: LISTAR MATRÍCULAS DA TURMA ---
// --- ROTA DE MATRICULAR ALUNO (Com trava de Projeto) ---
app.post("/turmas/:id/matriculas", async (req, res) => {
    const { id: turmaId } = req.params;
    const { aluno_id } = req.body;

    try {
        // 1. Descobre o PROJETO desta turma
        const [turmaAlvo] = await query("SELECT projeto_id FROM turmas WHERE id = ?", [turmaId]);
        
        if (!turmaAlvo) {
            return res.status(404).json({ error: "Turma não encontrada" });
        }
        const projetoAlvoId = turmaAlvo.projeto_id;

        // 2. SEGURANÇA: Verifica se o aluno já está em OUTRO projeto
        const sqlCheck = `
            SELECT t.projeto_id, t.nome as nome_turma
            FROM matriculas m
            JOIN turmas t ON m.turma_id = t.id
            WHERE m.aluno_id = ? 
            AND m.status = 'Ativo'
            LIMIT 1
        `;
        const [matriculaExistente] = await query(sqlCheck, [aluno_id]);

        // Se já tem matrícula em projeto diferente -> BLOQUEIA
        if (matriculaExistente && matriculaExistente.projeto_id !== projetoAlvoId) {
            return res.status(409).json({ 
                error: "CONFLITO DE PROJETO", 
                message: `Aluno já está no projeto da turma '${matriculaExistente.nome_turma}'.` 
            });
        }

        // 3. Insere a matrícula
        await query(
            "INSERT INTO matriculas (turma_id, aluno_id, status) VALUES (?, ?, 'Ativo')", 
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

// --- ROTA DE LISTAR MATRÍCULAS DA TURMA ---
// É essa rota que alimenta a tabela!
app.get("/turmas/:id/matriculas", async (req, res) => {
    try {
        const { id } = req.params;
        
        // Busca quem está nessa turma e já traz o ID e STATUS
        const sql = "SELECT * FROM matriculas WHERE turma_id = ?";
        const results = await query(sql, [id]);
        
        res.json(results);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- INICIALIZAÇÃO ---
const PORT = 10000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor SysFrequencia rodando na porta ${PORT}`);
});