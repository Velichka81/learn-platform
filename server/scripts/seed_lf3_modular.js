// Modular seeding for LF3 using ordered fixture files (01..04)
// Usage: node scripts/seed_lf3_modular.js
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { getDb } from '../src/db.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const FIXTURE_DIR = path.join(__dirname, '../fixtures/lf3');
const ORDER = [
  '01_structure.sql',
  '02_content.sql',
  '03_flashcards.sql',
  '04_quiz.sql'
];

function runSql(db, file) {
  const full = path.join(FIXTURE_DIR, file);
  if (!fs.existsSync(full)) {
    console.warn(`[seed:lf3] Skip missing ${file}`);
    return;
  }
  const sql = fs.readFileSync(full, 'utf8');
  db.exec(sql);
  console.log(`[seed:lf3] Executed ${file}`);
}

function main() {
  const db = getDb();
  db.pragma('foreign_keys=ON');
  ORDER.forEach(f => runSql(db, f));
  const units = db.prepare('SELECT COUNT(*) as c FROM units WHERE id BETWEEN 3601 AND 3610').get().c;
  const q = db.prepare('SELECT COUNT(*) as c FROM questions WHERE unit_id BETWEEN 3601 AND 3610').get().c;
  const f = db.prepare('SELECT COUNT(*) as c FROM flashcards WHERE unit_id BETWEEN 3601 AND 3610').get().c;
  console.log(`[seed:lf3] Units (3601-3610): ${units}, questions: ${q}, flashcards: ${f}`);
}

main();
