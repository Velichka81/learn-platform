// Validation script for quiz data integrity (LF1 scope by default)
import { getDb } from '../src/db.js';

function assert(cond, msg, issues) { if(!cond) issues.push(msg); }

function validateLF1() {
  const db = getDb();
  const issues = [];
  const questions = db.prepare("SELECT id, unit_id, type, stem FROM questions WHERE unit_id BETWEEN 1 AND 10").all();
  for (const q of questions) {
    if (q.type === 'gap') continue; // no options required
    const opts = db.prepare('SELECT label,is_correct FROM options WHERE question_id=?').all(q.id);
    assert(opts.length > 0, `No options q${q.id}` , issues);
    const correct = opts.filter(o=>o.is_correct).length;
    switch(q.type) {
      case 'tf':
        assert(opts.length === 2, `TF not 2 options q${q.id}`, issues);
        assert(correct === 1, `TF not exactly 1 correct q${q.id}`, issues);
        break;
      case 'sc':
        assert(opts.length >= 2, `SC <2 options q${q.id}`, issues);
        assert(correct === 1, `SC not exactly 1 correct q${q.id}`, issues);
        break;
      case 'mc':
        assert(opts.length >= 3, `MC <3 options q${q.id}`, issues);
        assert(correct >= 1, `MC has no correct option q${q.id}`, issues);
        break;
    }
    // duplicate labels
    const seen = new Set();
    for(const o of opts) {
      const key = o.label.trim().toLowerCase();
      assert(!seen.has(key), `Duplicate option label in q${q.id}: ${o.label}`, issues);
      seen.add(key);
    }
  }
  return issues;
}

function main() {
  const issues = validateLF1();
  if (issues.length === 0) {
    console.log('[validate:quiz] OK – no issues');
  } else {
    console.error('[validate:quiz] Found issues:');
    issues.forEach(i => console.error(' - ' + i));
    process.exitCode = 1;
  }
}

main();
