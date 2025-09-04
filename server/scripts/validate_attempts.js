import { queryAll, queryOne } from '../src/db.js';

// Simple diagnostic: find attempts with SC/TF questions storing >1 answers
const attempts = queryAll('SELECT id, detail_json FROM attempts WHERE finished_at IS NOT NULL ORDER BY id DESC LIMIT 100');
let issues = [];
for (const a of attempts) {
  try {
    const detail = JSON.parse(a.detail_json);
    if (!detail.answers) continue;
    for (const [qid, arr] of Object.entries(detail.answers)) {
      const q = queryOne('SELECT type, stem FROM questions WHERE id = ?', [qid]);
      if (!q) continue;
      if ((q.type === 'sc' || q.type === 'tf') && arr.length > 1) {
        issues.push({ attempt: a.id, question: qid, type: q.type, count: arr.length, stem: q.stem });
      }
    }
  } catch {}
}
if (!issues.length) {
  console.log('Keine Mehrfach-Auswahl Probleme bei SC/TF in letzten 100 Attempts.');
} else {
  console.log('Gefundene Probleme (SC/TF mit >1 gespeicherten Antworten):');
  console.table(issues);
}