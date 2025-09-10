// Modular seeding für LF6 (01_structure, 02_content, 03_flashcards, 04_quiz)
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { getDb } from '../src/db.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const FIXTURE_DIR = path.join(__dirname, '../fixtures/lf6');
const ORDER = ['01_structure.sql','02_content.sql','03_flashcards.sql','04_quiz.sql'];

function runSql(db, file) {
  const full = path.join(FIXTURE_DIR, file);
  if (!fs.existsSync(full)) { console.warn(`[seed:lf6] Datei fehlt: ${file}`); return; }
  const sql = fs.readFileSync(full, 'utf8');
  db.exec(sql);
  console.log(`[seed:lf6] Ausgeführt: ${file}`);
}

function main(){
  const db = getDb();
  db.pragma('foreign_keys=ON');
  ORDER.forEach(f=>runSql(db,f));
  const units = db.prepare('SELECT COUNT(*) as c FROM units WHERE id BETWEEN 6801 AND 6807').get().c;
  const flash = db.prepare('SELECT COUNT(*) as c FROM flashcards WHERE unit_id BETWEEN 6801 AND 6807').get().c;
  const ques = db.prepare('SELECT COUNT(*) as c FROM questions WHERE unit_id BETWEEN 6801 AND 6807').get().c;
  console.log(`[seed:lf6] Units (6801-6807): ${units}, Flashcards: ${flash}, Questions: ${ques}`);
}

main();
