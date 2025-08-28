import { getDb } from '../src/db.js';
const db=getDb();
const q=db.prepare("SELECT id, stem FROM questions WHERE stem LIKE '%Teilzeit ändert das Ausbildungsziel%' ").get();
if(!q){console.log('Frage nicht gefunden');process.exit(0);} 
console.log('Frage',q);
const opts=db.prepare('SELECT id,label,is_correct FROM options WHERE question_id=?').all(q.id);
console.log('Optionen:',opts);
