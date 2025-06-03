import sqlite3 from 'sqlite3';
import { fileURLToPath } from 'url';
import path, { dirname } from 'path';

const sql = sqlite3.verbose();

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const dbPath = path.resolve(__dirname, '../app/db/database.db');

const DB = new sql.Database(dbPath, sqlite3.OPEN_READWRITE, (err) => {
    if (err) {
        console.error(`Erro ao conectar ao banco de dados: ${err.message}`);
        return;
    }
})

export { DB };