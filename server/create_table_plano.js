const { querySys } = require('./src/config/database');

async function createTable() {
    try {
        const sql = `
            CREATE TABLE IF NOT EXISTS plano_trabalho (
                id INT AUTO_INCREMENT PRIMARY KEY,
                usuario_id INT NOT NULL,
                ano INT NOT NULL,
                mes INT NOT NULL,
                caminho_planejamento VARCHAR(255),
                caminho_relatorio VARCHAR(255),
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                UNIQUE KEY proc_mes_ano (usuario_id, ano, mes)
            );
        `;

        await querySys(sql);
        console.log("Tabela 'plano_trabalho' criada ou já existente com sucesso!");
        process.exit(0);
    } catch (error) {
        console.error("Erro ao criar tabela:", error);
        process.exit(1);
    }
}

createTable();
