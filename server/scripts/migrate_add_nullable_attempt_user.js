#!/usr/bin/env node
import { getDb } from '../src/db.js';

const db = getDb();
// Check if attempts.user_id is NOT NULL
const pragma = db.prepare("PRAGMA table_info(attempts)").all();
const col = pragma.find(c => c.name === 'user_id');
if (col && col.notnull === 1) {
  console.log('Migrating attempts.user_id to NULL-able ...');
  db.exec('BEGIN');
  db.exec(`CREATE TABLE attempts_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quiz_id INTEGER,
    user_id INTEGER,
    started_at TEXT NOT NULL,
    finished_at TEXT,
    score REAL,
    detail_json TEXT,
    scope TEXT,
    scope_ref TEXT,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
  );`);
  db.exec('INSERT INTO attempts_new (id, quiz_id, user_id, started_at, finished_at, score, detail_json, scope, scope_ref) SELECT id, quiz_id, user_id, started_at, finished_at, score, detail_json, scope, scope_ref FROM attempts;');
  db.exec('DROP TABLE attempts;');
  db.exec('ALTER TABLE attempts_new RENAME TO attempts;');
  db.exec('COMMIT');
  console.log('Migration done.');
} else {
  console.log('No migration needed.');
}
