// Fügt fehlende Options für die zweiten MC-Fragen der Units 6-10 hinzu, falls leer.
import { getDb } from '../src/db.js';
const db = getDb();

const data = {
  6: ['EntgFG|1','MuSchG|1','AGB|0'],
  7: ['Planbare Bedingungen|1','Willkürliche Kürzungen|0','Bessere Vergütung|1','Rechtsunsicherheit|0'],
  8: ['Interessenvertretung|1','Schlechterer Informationsfluss|0','Feedbackkanal|1','Rechtlose Stellung|0'],
  9: ['Einstieg|1','Hauptteil|1','Schluss|1','Unstrukturierter Block|0'],
 10: ['Berichtsheft|1','Feedbackgespräche|1','Spontane Zurufe|0']
};

for (const unit of Object.keys(data)) {
  const mc = db.prepare("SELECT id FROM questions WHERE unit_id=? AND type='mc' ORDER BY id").all(unit);
  if (mc.length < 2) continue;
  const secondId = mc[1].id;
  const optCount = db.prepare('SELECT COUNT(*) c FROM options WHERE question_id=?').get(secondId).c;
  if (optCount === 0) {
    const insert = db.prepare('INSERT INTO options(question_id,label,is_correct) VALUES (?,?,?)');
    const labels = data[unit];
    labels.forEach(l => {
      const [label, correct] = l.split('|');
      insert.run(secondId, label, Number(correct));
    });
    console.log(`Unit ${unit}: fehlende MC-Optionen eingefügt (${labels.length})`);
  } else {
    console.log(`Unit ${unit}: bereits Optionen vorhanden (${optCount})`);
  }
}

console.log('Fertig.');