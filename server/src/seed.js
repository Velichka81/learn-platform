import dotenv from 'dotenv';
dotenv.config({ path: '../../.env' });
import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';

try {
  const DB_PATH = process.env.DB_PATH || './learn.db';
  const db = new Database(DB_PATH);
  const seedDir = path.resolve('src/seed');
  const files = fs.readdirSync(seedDir).filter(f => f.endsWith('.sql')).sort();
  for (const file of files) {
    const sql = fs.readFileSync(path.join(seedDir, file), 'utf-8');
    db.exec(sql);
    console.log(`Seed: ${file}`);
  }
  console.log('Seeding complete');
  process.exit(0);
} catch (err) {
  console.error('Seeding failed:', err.message);
  process.exit(1);
}
