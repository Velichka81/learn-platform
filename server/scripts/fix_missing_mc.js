import { getDb } from '../src/db.js';
const db=getDb();
const mcFix={
  28:[['Gesundheitsschutz',1],['Förderung künstlicher Überstunden',0],['Verhinderung von Überforderung',1]],
  35:[['Familienpflichten',1],['Gesundheitliche Gründe',1],['Reines Interesse am kürzeren Tag',0],['Pflege Angehöriger',1]]
};
const ins=db.prepare('INSERT INTO options(question_id,label,is_correct) VALUES (?,?,?)');
for(const qid of Object.keys(mcFix)){
  const count=db.prepare('SELECT COUNT(*) c FROM options WHERE question_id=?').get(qid).c;
  if(count===0){ mcFix[qid].forEach(o=>ins.run(qid,o[0],o[1])); console.log('MC Optionen hinzugefügt für Frage',qid); }
  else console.log('Frage',qid,'hat bereits',count,'Optionen');
}
console.log('Done');
