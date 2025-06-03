import bodyParser from 'body-parser';
import express from 'express'
import { DB } from './connect.js';

const app = express();
const port = 3000

app.use(bodyParser.json());

//Inicia API
app.listen(port, (err) => {
    if (err) {
        console.log(err.message)
        return;
    }
    console.log(`Server running at http://localhost:${port}`)
})

//Método GET
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

//Método POST
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
                req.body.tutor, req.body.species, req.body.race, req.body.entry_date, req.body.exit_date
            ]
            DB.run(sql, request_data, (err) => {
                if (err) throw err;

                DB.get(sql_last_id, (err, row) => {
                    if (err) throw err;

                    res.json({
                        'id': row.id,
                        'message': `O cliente ${req.body.tutor} e seu ${req.body.species} foram salvos com sucesso.`
                    });
                });
            });
        } catch (err) {
            res.status(500).send(err.message);
        }
    });
});


//Método PUT
app.put('/api', (req, res) => {
    DB.serialize(() => {
        const sql = `
        UPDATE Pets
        SET tutor = ?, species = ?, race = ?, entry_date = ?, exit_date = ?
        WHERE id = ?
        `;

        try {
            const request_data = [
                req.body.tutor, req.body.species, req.body.race, req.body.entry_date, req.body.exit_date, req.query.id,
            ]
            DB.run(sql, request_data, (err) => {
                if (err) throw err;

                res.send(
                    `Os dados de ${req.body.tutor}, dono de ${req.body.species}, foram atualizados`
                );
            });
        } catch (err) {
            res.status(500).send(err.message);
        }
    });
});


//MÉTODO DELETE
app.delete('/api', (req, res) => {
    const sql = 'DELETE FROM Pets WHERE id = ?';
    try {
        DB.run(sql, [req.query.id], function (err) {
            if (err) throw err;
            res.send(`O cliente ${req.body.tutor} e seu ${req.body.species} foram excluídos com sucesso.`);
        });
    } catch (err) {
        res.status(500).send(err.message);
    }
});