const express = require('express'); // Force restart
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

// Servir arquivos estáticos (Fotos das aulas)
const path = require('path');
// Ajuste o caminho para subir 3 níveis a partir de 'server' (se 'server' for a raiz onde rodamos)
// Mas atenção: __dirname refere-se ao arquivo atual. Se index.js está em /server/index.js:
// ../../../public_html/uploads 
// Verifique se a estrutura é essa mesma. O user pediu: path.join(__dirname, '../../../public_html/uploads')
app.use('/uploads', express.static(path.join(__dirname, '../../../public_html/uploads')));

// Rota de teste
app.get('/', (req, res) => res.send('API Local Rodando! 🚀'));

const PORT = 10000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor Local rodando na porta ${PORT}`);
});