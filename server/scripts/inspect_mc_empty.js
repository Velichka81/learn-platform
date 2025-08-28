import { getDb } from '../src/db.js';
const db=getDb();
const rows=db.prepare("SELECT q.id,q.unit_id,q.stem, COUNT(o.id) c FROM questions q LEFT JOIN options o ON q.id=o.question_id WHERE q.type='mc' GROUP BY q.id HAVING c=0").all();
console.log('MC ohne Optionen:', rows.length); if(rows.length) console.log(rows);
