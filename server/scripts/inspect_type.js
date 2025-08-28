import { getDb } from '../src/db.js';
const db=getDb();
const q=db.prepare('SELECT id,type FROM questions WHERE id=34').get();
console.log(q);
