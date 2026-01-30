const mysql = require('mysql2');
require('dotenv').config();

const defaultOptions = {
    host: "localhost",
    user: "root",
    password: "Karolinne10", // Sua senha
    
};

// Cria o Pool de conexões
const dbSysConex = mysql.createPool({
    ...defaultOptions,
    database: "somosc28_frequenciaBeneficiario"
});

// Helper para usar Async/Await no SysConex (pra deixar o código moderno)
// Exemplo de uso: await querySys(sql, params)
const querySys = (sql, params) => {
    return new Promise((resolve, reject) => {
        dbSysConex.query(sql, params, (err, result) => {
            if (err) reject(err);
            else resolve(result);
        });
    });
};

// Exporta para quem precisar usar
module.exports = { dbSysConex, querySys };