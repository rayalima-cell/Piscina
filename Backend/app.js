const express = require('express');
const cors = require('cors');
const connection = require ('./db')

const server = express();

server.use(cors());
server.use(express.json());

const port = 3025;

server.get("/responsaveis", (req, res) =>{
    const sql = 'SELECT * FROM Responsavel';

    connection.query(sql, (erro, resultados) => {
        if(erro){
            console.log('Erro ao buscar responsavel: ', erro);
            res.status(500).send('Erro ao buscar responsavel');
            return;
        }
        res.send(resultados);
    });
});

server.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});