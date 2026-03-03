const { querySys } = require('./src/config/database');

async function alterTable() {
    try {
        const sql = `ALTER TABLE plano_trabalho ADD COLUMN feedback_coordenador TEXT AFTER caminho_relatorio;`;
        await querySys(sql);
        console.log("Feedback column added successfully.");
        process.exit(0);
    } catch (error) {
        if (error.code === 'ER_DUP_FIELDNAME') {
            console.log("Column already exists.");
            process.exit(0);
        } else {
            console.error("Error adding column:", error);
            process.exit(1);
        }
    }
}

alterTable();
