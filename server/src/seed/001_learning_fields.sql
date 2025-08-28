-- Reduzierte Seed-Daten: nur LF1 mit gewünschter ID 1001
DELETE FROM learning_fields; -- sicherstellen, dass keine alten Einträge stören
INSERT INTO learning_fields (id, code, title, exam_phase, position) VALUES
(1001, 'LF1', 'Das Unternehmen und die eigene Rolle im Betrieb beschreiben', 'AP1', 1);

-- Optional: Sequenz hochsetzen, damit zukünftige AUTOINCREMENT IDs nicht kollidieren
UPDATE sqlite_sequence SET seq = 1001 WHERE name = 'learning_fields';
