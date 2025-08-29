// Modular seeding for LF2 using ordered fixture files (01..04)
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { getDb } from '../src/db.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const FIXTURE_DIR = path.join(__dirname, '../fixtures/lf2');
const ORDER = [
  '01_structure.sql',
  '02_content.sql',
  '03_flashcards.sql',
  '04_quiz.sql'
];

function runSql(db, file) {
  const full = path.join(FIXTURE_DIR, file);
  const sql = fs.readFileSync(full, 'utf8');
  db.exec(sql);
  console.log(`[seed:lf2] Executed ${file}`);
}

function main() {
  const db = getDb();
  db.pragma('foreign_keys=ON');
  ORDER.forEach(f => runSql(db, f));
  const q = db.prepare('SELECT COUNT(*) as c FROM questions WHERE unit_id BETWEEN 201 AND 224').get().c;
  const f = db.prepare('SELECT COUNT(*) as c FROM flashcards WHERE unit_id BETWEEN 201 AND 224').get().c;
  console.log(`[seed:lf2] Total LF2 questions (201-224): ${q}, flashcards: ${f}`);
}

main();
