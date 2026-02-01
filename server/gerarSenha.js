const bcrypt = require('bcryptjs');

const senha = '1234'; // A senha que você quer
const salt = bcrypt.genSaltSync(10);
const hash = bcrypt.hashSync(senha, salt);

console.log('--- COPIE O HASH ABAIXO ---');
console.log(hash);
console.log('---------------------------');