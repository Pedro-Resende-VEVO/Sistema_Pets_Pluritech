import bodyParser from 'body-parser';
import express from 'express'
import { DB } from './connect.js';

/**
 * Servidor Express responsável pela API REST do sistema de hotel para pets.
 */
const app = express();
const port = 3000

app.use(bodyParser.json());

/**
 * Inicia o servidor na porta definida.
 */
app.listen(port, (err) => {
    if (err) {
        console.log(err.message)
        return;
    }
    console.log(`Server running at http://localhost:${port}`)
})

/**
 * Rota GET /api
 * Retorna todos os registros da tabela Pets.
 */
app.get('/api', (req, res) => {
    const sql = 'SELECT * FROM Pets';
    try {
        DB.all(sql, [], (err, row) => {
            if (err) throw err;
            res.json(row);
        });
    } catch (err) {
        res.status(500).send(err.message);
    }
});

/**
 * Rota POST /api
 * Insere um novo registro na tabela Pets.
 */
app.post('/api', (req, res) => {
    DB.serialize(() => {
        const sql = `
        INSERT INTO Pets(tutor, species, race, entry_date, exit_date)
        VALUES (? , ?, ? , ? , ?)
        `;

        const sql_last_id = `
        SELECT last_insert_rowid() AS id
        `

        try {
            const request_data = [
                req.query.tutor, req.query.species, req.query.race, req.query.entry_date, req.query.exit_date
            ]
            DB.run(sql, request_data, (err) => {
                if (err) throw err;

                DB.get(sql_last_id, (err, row) => {
                    if (err) throw err;

                    res.json({
                        'id': row.id,
                        'message': `O cliente ${req.query.tutor} e seu ${req.query.species} foram salvos com sucesso.`
                    });
                });
            });
        } catch (err) {
            res.status(500).send(err.message);
        }
    });
});

/**
 * Rota PUT /api
 * Atualiza um registro existente na tabela Pets.
 */
app.put('/api', (req, res) => {
    const sql = `
        UPDATE Pets
        SET tutor = ?, species = ?, race = ?, entry_date = ?, exit_date = ?
        WHERE id = ?
        `;

    try {
        const request_data = [
            req.query.tutor, req.query.species, req.query.race, req.query.entry_date, req.query.exit_date, req.query.id,
        ]
        DB.run(sql, request_data, (err) => {
            if (err) throw err;

            res.send(
                `Os dados de ${req.query.tutor}, dono de ${req.query.species}, foram atualizados`
            );
        });
    } catch (err) {
        res.status(500).send(err.message);
    }
});

/**
 * Rota DELETE /api
 * Remove um registro da tabela Pets pelo id.
 */
app.delete('/api', (req, res) => {
    DB.serialize(() => {
        const sql = 'DELETE FROM Pets WHERE id = ?';
        const sql_before_delete = 'SELECT * FROM Pets WHERE id = ?';

        try {
            DB.all(sql_before_delete, [req.query.id], function (err, row) {
                if (err) throw err;
                const tutor = row[0]['tutor']
                const species = row[0]['species']

                DB.run(sql, [req.query.id], function (err) {
                    if (err) throw err;

                    res.send(`O cliente ${tutor} e seu ${species} foram excluídos com sucesso.`);
                });
            })
        } catch (err) {
            res.status(500).send(err.message);
        }
    })
});