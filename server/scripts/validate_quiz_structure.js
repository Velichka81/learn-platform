// Validate quiz question-option structural integrity across all learning fields
// Checks:
// 1. Non-gap questions have at least required option counts (sc>=4, mc>=4, tf==2)
// 2. Each question has exactly one correct option for sc/tf and >=2 for mc
// 3. Reports summary counts
// (Semantic relevance of options to stems is not auto-validated here.)

import { getDb } from '../src/db.js';

function main() {
  const db = getDb();
  const questions = db.prepare("SELECT id, unit_id, type, stem FROM questions WHERE type != 'gap'").all();
  const problems = [];
  let counts = { sc:0, tf:0, mc:0 };
  for (const q of questions) {
    counts[q.type]++;
    const opts = db.prepare('SELECT id, label, is_correct FROM options WHERE question_id = ?').all(q.id);
    const correct = opts.filter(o=>o.is_correct);
    if (q.type === 'tf') {
      if (opts.length !== 2) problems.push({ id:q.id, issue:`TF has ${opts.length} options (expected 2)` });
      if (correct.length !== 1) problems.push({ id:q.id, issue:`TF has ${correct.length} correct options (expected 1)` });
    } else if (q.type === 'sc') {
      if (opts.length < 4) problems.push({ id:q.id, issue:`SC has ${opts.length} options (<4)` });
      if (correct.length !== 1) problems.push({ id:q.id, issue:`SC has ${correct.length} correct options (expected 1)` });
    } else if (q.type === 'mc') {
      if (opts.length < 4) problems.push({ id:q.id, issue:`MC has ${opts.length} options (<4)` });
      if (correct.length < 2) problems.push({ id:q.id, issue:`MC has ${correct.length} correct options (<2)` });
    }
  }
  console.log('Question counts:', counts);
  if (problems.length) {
    console.log('Problems found:', problems.length);
    for (const p of problems) console.log(p);
  } else {
    console.log('No structural problems detected.');
  }
}

main();
