import { getDb } from '../src/db.js';
const db=getDb();
const tfs=db.prepare("SELECT id, unit_id, stem FROM questions WHERE type='tf'").all();
for(const q of tfs){
  const opts=db.prepare('SELECT id,label,is_correct FROM options WHERE question_id=?').all(q.id);
  if(opts.length!==2){
    console.log('TF Frage mit',opts.length,'Optionen:',q.id,'Unit',q.unit_id,q.stem,opts);
  }
}
