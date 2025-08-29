// Development auto-seed helper.
// Ensures schema, LF1 structure and LF1 quiz questions exist so that the quiz UI is not empty.
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { getDb } from './db.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export function ensureDevSeed() {
  const db = getDb();
  try {
    // 1. Schema
    const hasLearningFields = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name='learning_fields'").get();
    if (!hasLearningFields) {
      const schema = fs.readFileSync(path.join(__dirname, 'schema.sql'), 'utf8');
      db.exec(schema);
      console.log('[seed] Schema angewendet');
    }

    // 2. If no questions at all -> seed LF1 structure + quiz questions
    const qCount = db.prepare("SELECT COUNT(*) as c FROM questions WHERE type!='gap'").get().c;
    if (qCount === 0) {
      console.log('[seed] Keine SC/MC/TF Fragen – führe LF1 Grund-Seed & Quiz-Seed aus');
      seedLF1Structure(db);
      seedLF1Quiz(db);
    }
  } catch (err) {
    console.error('[seed] Fehler beim automatischen Seed:', err.message);
  }
}

function seedLF1Structure(db) {
  // Only if LF1 not present
  const exists = db.prepare('SELECT id FROM learning_fields WHERE id=1001').get();
  if (exists) { return; }
  db.exec('PRAGMA foreign_keys=ON');
  db.prepare('INSERT INTO learning_fields (id, code, title, exam_phase, position) VALUES (1001, ?, ?, ?, 1)')
    .run('LF1', 'Das Unternehmen und die eigene Rolle im Betrieb beschreiben', 'AP1');
  db.prepare('INSERT INTO chapters (id, learning_field_id, title, position) VALUES (1, 1001, ?, 1)')
    .run('LF1: Das Unternehmen und die eigene Rolle im Betrieb');
  const topics = [
    ['T1. IT-Ausbildungsberufe & duales System (Überblick)', 'Überblick über IT-Berufe, gemeinsamer Kern der Lernfelder 1–6, Lernorte Betrieb & Berufsschule, Rolle der IHK.'],
    ['T2. Gestreckte Abschlussprüfung & Zeugnisse', 'Gestreckte Abschlussprüfung: Teil 1 (20%), Teil 2 schriftlich + Projekt/Fachgespräch. Zeugnisse von BBS, IHK, Betrieb.'],
    ['T3. Rechte & Pflichten im Ausbildungsverhältnis (BBiG) + Ausbildungsvertrag', 'Pflichten Azubi/Ausbildende, Freistellung, Mindestinhalte § 11 BBiG.'],
    ['T4. Jugendarbeitsschutzgesetz (JArbSchG)', 'Arbeitszeiten, Pausen, Berufsschule, Urlaub, Freistellung vor Prüfungen.'],
    ['T5. Vergütung, Abzüge, Teilzeitausbildung', 'Ausbildungsvergütung: Zusammensetzung, Abzüge (Steuern, SV). Teilzeit nach § 8 BBiG.'],
    ['T6. Arbeitsrecht-Basics', 'Überblick zentrale Gesetze: ArbZG, TzBfG, KSchG, AGG, MiLoG, BUrlG, MuSchG/BEEG.'],
    ['T7. Mitbestimmung: Betriebsrat, Betriebsvereinbarungen, Tarifvertrag & Streik', 'Betriebsrat, Tarifautonomie, Streik & Aussperrung – Rechte und Grenzen.'],
    ['T8. JAV (Jugend- und Auszubildendenvertretung)', 'JAV: Wahl, Aufgaben, Zusammenarbeit mit BR/Gewerkschaft.'],
    ['T9. Ausbildungsbetrieb präsentieren', 'Planung Präsentation: Zielgruppe, Recherche, Aufbau, Visualisierung.'],
    ['T10. Betriebsnahes Lernen: Ausbildungsplan & Einsatzrotation', 'Ausbildungsplan: sachliche/zeitliche Gliederung, Rotation, Verantwortung.'],
  ];
  const insertTopic = db.prepare('INSERT INTO topics (id, chapter_id, title, position) VALUES (?, 1, ?, ?)');
  const insertUnit = db.prepare('INSERT INTO units (id, topic_id, title, summary, content_html) VALUES (?, ?, ?, ?, ?)');
  topics.forEach((t, idx) => {
    const id = idx + 1;
    insertTopic.run(id, t[0], id);
    insertUnit.run(id, id, t[0], t[1], `<p>${t[1]}</p>`);
  });
  console.log('[seed] LF1 Struktur angelegt');
}

function seedLF1Quiz(db) {
  try {
    // Prefer modular fixtures if present
    const modularDir = path.join(__dirname, '../fixtures/lf1');
    const modularExists = fs.existsSync(path.join(modularDir, '04_quiz.sql'));
    if (modularExists) {
      ['01_structure.sql','02_content.sql','03_flashcards.sql','04_quiz.sql'].forEach(f => {
        const sql = fs.readFileSync(path.join(modularDir, f), 'utf8');
        db.exec(sql);
      });
      const cnt = db.prepare('SELECT COUNT(*) as c FROM questions').get().c;
      console.log(`[seed] LF1 Quizfragen (modular) eingefügt: ${cnt}`);
      return;
    }
    // Fallback legacy file
    const sqlPath = path.join(__dirname, '../fixtures/quizzes_lf1_units.sql');
    const sql = fs.readFileSync(sqlPath, 'utf8');
    db.exec(sql);
    const cnt = db.prepare('SELECT COUNT(*) as c FROM questions').get().c;
    console.log(`[seed] LF1 Quizfragen (legacy) eingefügt: ${cnt}`);
  } catch (e) {
    console.error('[seed] Fehler beim Quiz-Seed:', e.message);
  }
}
