// Modular Seeder für LF4 (CommonJS)
const fs = require('fs');
const path = require('path');
const sqlite3 = require('sqlite3').verbose();
require('dotenv').config();

const DB_PATH = process.env.DB_PATH;
const FIXTURES_DIR = path.join(__dirname, '../fixtures/lf4');

const files = [
  '01_structure.sql',
  '02_content.sql',
  // '03_flashcards.sql',
  // '04_quiz.sql',
];

function runSqlFile(db, filePath) {
  return new Promise((resolve, reject) => {
    const sql = fs.readFileSync(filePath, 'utf8');
    db.exec(sql, (err) => {
      if (err) reject(err);
      else resolve();
    });
  });
}

async function seed() {
  if (!DB_PATH) {
    console.error('DB_PATH not set in .env');
    process.exit(1);
  }
  const db = new sqlite3.Database(DB_PATH);
  try {
    for (const file of files) {
      const filePath = path.join(FIXTURES_DIR, file);
      if (fs.existsSync(filePath)) {
        console.log(`[seed:lf4] Executing ${file} ...`);
        await runSqlFile(db, filePath);
      }
    }
    console.log('[seed:lf4] Done.');
  } catch (err) {
    console.error('[seed:lf4] Error:', err);
  } finally {
    db.close();
  }
}

seed();
