import Database from 'better-sqlite3';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.join(__dirname, '../.env') });

let _db = null;

function getDb() {
	if (!_db) {
		try {
			const DB_PATH = process.env.DB_PATH || './learn.db';
			_db = new Database(DB_PATH);
			_db.pragma('foreign_keys = ON');
			_db.pragma('journal_mode = WAL');
		} catch (err) {
			throw new Error('Fehler beim Öffnen der Datenbank: ' + err.message);
		}
	}
	return _db;
}

function queryAll(sql, params = []) {
	try {
		return getDb().prepare(sql).all(params);
	} catch (err) {
		throw new Error('DB queryAll fehlgeschlagen: ' + err.message + '\nSQL: ' + sql);
	}
}

function queryOne(sql, params = []) {
	try {
		return getDb().prepare(sql).get(params);
	} catch (err) {
		throw new Error('DB queryOne fehlgeschlagen: ' + err.message + '\nSQL: ' + sql);
	}
}

function run(sql, params = []) {
	try {
		return getDb().prepare(sql).run(params);
	} catch (err) {
		throw new Error('DB run fehlgeschlagen: ' + err.message + '\nSQL: ' + sql);
	}
}

function transaction(fn) {
	const db = getDb();
	const trx = db.transaction(fn);
	try {
		return trx(db);
	} catch (err) {
		throw new Error('DB transaction fehlgeschlagen: ' + err.message);
	}
}

export { getDb, queryAll, queryOne, run, transaction };
