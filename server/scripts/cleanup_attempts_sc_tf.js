import { queryAll, queryOne, run } from '../src/db.js';

const attempts = queryAll('SELECT id, detail_json FROM attempts WHERE finished_at IS NOT NULL');
let fixed = 0;
for (const a of attempts) {
  let changed = false;
  const detail = JSON.parse(a.detail_json);
  if (!detail.answers) continue;
  for (const [qid, arr] of Object.entries(detail.answers)) {
    const q = queryOne('SELECT type FROM questions WHERE id = ?', [qid]);
    if (!q) continue;
    if ((q.type === 'sc' || q.type === 'tf') && Array.isArray(arr) && arr.length > 1) {
      // keep last entry only
      detail.answers[qid] = [arr[arr.length-1]];
      changed = true; fixed++;
    }
  }
  if (changed) run('UPDATE attempts SET detail_json = ? WHERE id = ?', [JSON.stringify(detail), a.id]);
}
console.log('Bereinigt SC/TF Antworten (Mehrfachspeicherungen reduziert):', fixed);