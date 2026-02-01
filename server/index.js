const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Configurações
app.use(cors());
app.use(express.json());

// Importa as rotas
const sysconexRoutes = require('./src/routes/sysconex');

// Usa as rotas com o prefixo correto (IGUAL AO SERVER)
app.use('/sysconex-freq', sysconexRoutes);

// Rota de teste
app.get('/', (req, res) => res.send('API Local Rodando! 🚀'));

const PORT = 10000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor Local rodando na porta ${PORT}`);
});