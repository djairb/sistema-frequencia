require('dotenv').config();
const mysql = require('mysql2/promise');

async function main() {
    const connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
    });

    try {
        console.log("Adding feedback column...");
        await connection.query(`
            ALTER TABLE plano_trabalho ADD COLUMN feedback_coordenador TEXT AFTER caminho_relatorio;
        `);
        console.log("Feedback column added successfully.");
    } catch (error) {
        if (error.code === 'ER_DUP_FIELDNAME') {
            console.log("Column already exists.");
        } else {
            console.error("Error adding column:", error);
        }
    } finally {
        await connection.end();
    }
}

main();
