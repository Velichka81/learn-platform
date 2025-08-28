import { getDb } from '../src/db.js';
const db = getDb();
const c = db.prepare('SELECT COUNT(*) as c FROM questions').get().c;
const perType = db.prepare('SELECT type, COUNT(*) c FROM questions GROUP BY type').all();
console.log('Total questions:', c, perType);
