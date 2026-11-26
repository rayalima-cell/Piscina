const mysql = require('mysql2');

// Ajuste usuário e senha conforme o MySQL da máquina
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'PISCINA',
    dateStrings: true
});

connection.connect((erro) => {
    if (erro) {
        console.log('Erro ao conectar:', erro.message);
        return;
    }
    console.log('Banco conectado com sucesso!');
});

module.exports = connection;