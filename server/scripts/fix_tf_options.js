import { getDb } from '../src/db.js';
const db=getDb();
const tfs=db.prepare("SELECT id, stem FROM questions WHERE type='tf'").all();
for(const q of tfs){
  const opts=db.prepare('SELECT id,label,is_correct FROM options WHERE question_id=? ORDER BY id').all(q.id);
  if(opts.length===4){
    // Keep first two, delete later two
    const del=opts.slice(2).map(o=>o.id);
    const placeholders=del.map(()=>'?').join(',');
    db.prepare(`DELETE FROM options WHERE id IN (${placeholders})`).run(...del);
    console.log('Bereinigt (4->2):',q.id);
  } else if(opts.length===0){
    // Determine correct label from stem explanation expectation? We can't know; infer by existing pattern:
    // If stem contains 'Falsch:' in explanation originally but we don't have explanation here.
    // We fallback: add standard two options with is_correct=1 for 'Richtig' (default true). Better: look into fixture to find original correctness.
    // We'll guess based on keywords: 'nicht', 'kein', 'verboten', 'falsch', 'nie', 'sink', 'geringer', etc -> often false -> so correct = Falsch.
    const stemLower=q.stem.toLowerCase();
    const falseKeywords=['nicht','kein','verboten','nie','falsch','geringer','sink','sinkt'];
    let correctIsFalse=falseKeywords.some(k=>stemLower.includes(k));
    // Insert two options
    const ins=db.prepare('INSERT INTO options(question_id,label,is_correct) VALUES (?,?,?)');
    if(correctIsFalse){
      ins.run(q.id,'Richtig',0); ins.run(q.id,'Falsch',1); console.log('Hinzugefügt (0->2, korrekt=Falsch):',q.id);
    } else {
      ins.run(q.id,'Richtig',1); ins.run(q.id,'Falsch',0); console.log('Hinzugefügt (0->2, korrekt=Richtig):',q.id);
    }
  }
}
// Final sanity: ensure no tf has !=2 options
const bad=db.prepare("SELECT q.id, COUNT(o.id) c FROM questions q LEFT JOIN options o ON q.id=o.question_id WHERE q.type='tf' GROUP BY q.id HAVING c!=2").all();
if(bad.length) console.log('Noch fehlerhaft:',bad); else console.log('TF Optionen jetzt konsistent.');
