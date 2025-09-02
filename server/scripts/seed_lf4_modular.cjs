// Modular Seeder für LF4 (CommonJS)
const fs = require('fs');
const path = require('path');
const sqlite3 = require('better-sqlite3');
require('dotenv').config();

const DB_PATH = process.env.DB_PATH;
const FIXTURES_DIR = path.join(__dirname, '../fixtures/lf4');

const files = [
  '01_structure.sql',
  '02_content.sql',
  '03_flashcards.sql',
  '04_quiz.sql'
];

function runSqlFile(db, filePath) {
  const sql = fs.readFileSync(filePath, 'utf8');
  db.exec(sql);
}

async function seed() {
  if (!DB_PATH) {
    console.error('DB_PATH not set in .env');
    process.exit(1);
  }
  const db = new sqlite3(DB_PATH);
  try {
    db.pragma('foreign_keys=ON');
    for (const file of files) {
      const filePath = path.join(FIXTURES_DIR, file);
      if (fs.existsSync(filePath)) {
        console.log(`[seed:lf4] Executing ${file} ...`);
        runSqlFile(db, filePath);
      }
    }
    const units = db.prepare('SELECT COUNT(*) as c FROM units WHERE id BETWEEN 4801 AND 4809').get().c;
    const questions = db.prepare('SELECT COUNT(*) as c FROM questions WHERE unit_id BETWEEN 4801 AND 4809').get().c;
    const flashcards = db.prepare('SELECT COUNT(*) as c FROM flashcards WHERE unit_id BETWEEN 4801 AND 4809').get().c;
    console.log(`[seed:lf4] Units (4801-4809): ${units}, questions: ${questions}, flashcards: ${flashcards}`);
    console.log('[seed:lf4] Done.');
  } catch (err) {
    console.error('[seed:lf4] Error:', err);
  }
}

seed();
