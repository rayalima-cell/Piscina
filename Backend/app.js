const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

// chave para criptografar / descriptografar o CPF (LGPD)
const CHAVE = 'saep2026';

// =========================================================
// LOGIN
// =========================================================
app.post('/login', (req, res) => {
    const { login, senha } = req.body;

    const sql = 'SELECT id, nome FROM usuarios WHERE login = ? AND senha = SHA2(?, 256)';

    db.query(sql, [login, senha], (erro, resultado) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro no servidor.' });

        if (resultado.length === 0) {
            return res.status(401).json({ mensagem: 'Login ou senha inválidos.' });
        }

        res.json(resultado[0]);
    });
});

// =========================================================
// Responsáveis
// =========================================================

// listar e buscar pelo nome
app.get('/responsaveis', (req, res) => {
    const busca = '%' + (req.query.busca || '') + '%';

    const sql = `SELECT id, nome, CAST(AES_DECRYPT(cpf, ?) AS CHAR) AS cpf, email, telefone
                   FROM responsaveis
                  WHERE nome LIKE ?
                  ORDER BY nome`;

    db.query(sql, [CHAVE, busca], (erro, resultado) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao listar.' });
        res.json(resultado);
    });
});

// cadastrar
app.post('/responsaveis', (req, res) => {
    const { nome, cpf, email, telefone } = req.body;

    const sql = `INSERT INTO responsaveis (nome, cpf, email, telefone)
                 VALUES (?, AES_ENCRYPT(?, ?), ?, ?)`;

    db.query(sql, [nome, cpf, CHAVE, email, telefone], (erro) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao cadastrar.' });
        res.json({ mensagem: 'Cadastrado com sucesso!' });
    });
});

// editar
app.put('/responsaveis/:id', (req, res) => {
    const { nome, cpf, email, telefone } = req.body;

    const sql = `UPDATE responsaveis
                    SET nome = ?, cpf = AES_ENCRYPT(?, ?), email = ?, telefone = ?
                  WHERE id = ?`;

    db.query(sql, [nome, cpf, CHAVE, email, telefone, req.params.id], (erro) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao atualizar.' });
        res.json({ mensagem: 'Atualizado com sucesso!' });
    });
});

// =========================================================
// Filhos
// =========================================================

// listar (com o nome do responsável)
app.get('/filhos', (req, res) => {
    const sql = `SELECT f.id, f.nome, f.data_nascimento, f.nivel, r.nome AS responsavel
                   FROM filhos f
                   JOIN responsaveis r ON r.id = f.responsavel_id
                  ORDER BY f.nome`;

    db.query(sql, (erro, resultado) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao listar.' });
        res.json(resultado);
    });
});

// cadastrar associado a um responsável
app.post('/filhos', (req, res) => {
    const { responsavel_id, nome, data_nascimento, nivel } = req.body;

    const sql = `INSERT INTO filhos (responsavel_id, nome, data_nascimento, nivel)
                 VALUES (?, ?, ?, ?)`;

    db.query(sql, [responsavel_id, nome, data_nascimento, nivel], (erro) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao cadastrar.' });
        res.json({ mensagem: 'Cadastrado com sucesso!' });
    });
});

// =========================================================
// Agendamentos
// =========================================================

// listar ordenado por dia, com os dados do filho e do responsável
app.get('/agendamentos', (req, res) => {
    const sql = `SELECT a.id, a.professor, a.data_agendamento,
                        TIME_FORMAT(a.horario, '%H:%i') AS horario,
                        f.nome AS filho, f.data_nascimento, f.nivel,
                        r.nome AS responsavel, CAST(AES_DECRYPT(r.cpf, ?) AS CHAR) AS cpf,
                        r.email, r.telefone
                   FROM agendamentos a
                   JOIN filhos f       ON f.id = a.filho_id
                   JOIN responsaveis r ON r.id = f.responsavel_id
                  ORDER BY a.data_agendamento, a.horario`;

    db.query(sql, [CHAVE], (erro, resultado) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao listar.' });
        res.json(resultado);
    });
});

// cadastrar
app.post('/agendamentos', (req, res) => {
    const { filho_id, professor, data_agendamento, horario } = req.body;

    const sql = `INSERT INTO agendamentos (filho_id, professor, data_agendamento, horario)
                 VALUES (?, ?, ?, ?)`;

    db.query(sql, [filho_id, professor, data_agendamento, horario], (erro) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao cadastrar.' });
        res.json({ mensagem: 'Cadastrado com sucesso!' });
    });
});

// atualizar a data
app.put('/agendamentos/:id', (req, res) => {
    const { data_agendamento } = req.body;

    const sql = 'UPDATE agendamentos SET data_agendamento = ? WHERE id = ?';

    db.query(sql, [data_agendamento, req.params.id], (erro) => {
        if (erro) return res.status(500).json({ mensagem: 'Erro ao atualizar.' });
        res.json({ mensagem: 'Data atualizada com sucesso!' });
    });
});

app.listen(3000, () => {
    console.log('API rodando em http://localhost:3000');
});
