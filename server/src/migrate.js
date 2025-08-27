import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.join(__dirname, '../.env') });
import Database from 'better-sqlite3';
import fs from 'fs';

try {
  const DB_PATH = process.env.DB_PATH || './learn.db';
  const db = new Database(DB_PATH);
  const schemaPath = path.join(__dirname, 'schema.sql');
  const schema = fs.readFileSync(schemaPath, 'utf-8');
  db.exec(schema);
  console.log('Migration complete');
  process.exit(0);
} catch (err) {
  console.error('Migration failed:', err.message);
  process.exit(1);
}
