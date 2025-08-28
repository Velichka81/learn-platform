#!/usr/bin/env node
import { getDb } from '../src/db.js';
import fs from 'fs';
import path from 'path';

const db = getDb();

function reseed() {
  db.exec('PRAGMA foreign_keys=ON');
  // Falls Tabellen nicht existieren: Schema laden
  const hasLearningFields = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name='learning_fields'").get();
  if (!hasLearningFields) {
    const schemaPath = path.join(process.cwd(), 'src', 'schema.sql');
    const schema = fs.readFileSync(schemaPath, 'utf8');
    db.exec(schema);
    console.log('Schema angewendet.');
  }
  // Lösche vorhandene LF1 Struktur
  db.exec(`DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=1001));
           DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=1001);
           DELETE FROM chapters WHERE learning_field_id=1001;
           DELETE FROM learning_fields WHERE id=1001;`);

  db.prepare('INSERT INTO learning_fields (id, code, title, exam_phase, position) VALUES (1001, ?, ?, ?, 1)')
    .run('LF1', 'Das Unternehmen und die eigene Rolle im Betrieb beschreiben', 'AP1');

  db.prepare('INSERT INTO chapters (id, learning_field_id, title, position) VALUES (1, 1001, ?, 1)')
    .run('LF1: Das Unternehmen und die eigene Rolle im Betrieb');

  // Alle Umlaute/ Sonderzeichen als Unicode Escapes, um Editor-Encoding-Probleme auszuschließen
  const topics = [
    ['T1. IT-Ausbildungsberufe & duales System (\u00dcberblick)', '\u00dcberblick \u00fcber IT-Berufe, gemeinsamer Kern der Lernfelder 1\u20136, Lernorte Betrieb & Berufsschule, Rolle der IHK.'],
    ['T2. Gestreckte Abschlusspr\u00fcfung & Zeugnisse', 'Gestreckte Abschlusspr\u00fcfung: Teil 1 (20%), Teil 2 schriftlich + Projekt/Fachgespr\u00e4ch. Zeugnisse von BBS, IHK, Betrieb.'],
    ['T3. Rechte & Pflichten im Ausbildungsverh\u00e4ltnis (BBiG) + Ausbildungsvertrag', 'Pflichten Azubi/Ausbildende, Freistellung, Mindestinhalte \u00a7 11 BBiG.'],
    ['T4. Jugendarbeitsschutzgesetz (JArbSchG)', 'Arbeitszeiten, Pausen, Berufsschule, Urlaub, Freistellung vor Pr\u00fcfungen.'],
    ['T5. Verg\u00fctung, Abz\u00fcge, Teilzeitausbildung', 'Ausbildungsverg\u00fctung: Zusammensetzung, Abz\u00fcge (Steuern, SV). Teilzeit nach \u00a7 8 BBiG.'],
    ['T6. Arbeitsrecht-Basics', '\u00dcberblick zentrale Gesetze: ArbZG, TzBfG, KSchG, AGG, MiLoG, BUrlG, MuSchG/BEEG.'],
    ['T7. Mitbestimmung: Betriebsrat, Betriebsvereinbarungen, Tarifvertrag & Streik', 'Betriebsrat, Tarifautonomie, Streik & Aussperrung \u2013 Rechte und Grenzen.'],
    ['T8. JAV (Jugend- und Auszubildendenvertretung)', 'JAV: Wahl, Aufgaben, Zusammenarbeit mit BR/Gewerkschaft.'],
    ['T9. Ausbildungsbetrieb pr\u00e4sentieren', 'Planung Pr\u00e4sentation: Zielgruppe, Recherche, Aufbau, Visualisierung.'],
    ['T10. Betriebsnahes Lernen: Ausbildungsplan & Einsatzrotation', 'Ausbildungsplan: sachliche/zeitliche Gliederung, Rotation, Verantwortung.'],
  ];

  const insertTopic = db.prepare('INSERT INTO topics (id, chapter_id, title, position) VALUES (?, 1, ?, ?)');
  const insertUnit = db.prepare('INSERT INTO units (id, topic_id, title, summary, content_html) VALUES (?, ?, ?, ?, ?)');

  topics.forEach((t, idx) => {
    const id = idx + 1;
    insertTopic.run(id, t[0], id);
    insertUnit.run(id, id, t[0], t[1], `<p>${t[1]}</p>`);
  });

  console.log('LF1 reseeded mit Umlauten (UTF-8)');
}

reseed();
