-- LF5 Struktur (ein Kapitel, 7 Topics/Units T1..T7)
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=5005));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=5005);
DELETE FROM chapters WHERE learning_field_id=5005;
DELETE FROM learning_fields WHERE id=5005;

INSERT INTO learning_fields(id,code,title,exam_phase,position) VALUES (5005,'LF5','Software zur Verwaltung von Daten anpassen','AP2',5);
INSERT INTO chapters(id,learning_field_id,title,position) VALUES (5500,5005,'LF5: Software zur Verwaltung von Daten anpassen',1);

-- Topics / Units (Topic-ID == Unit-ID)
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (5801,5500,'T1. Umfeld der Softwareentwicklung analysieren',1),
 (5802,5500,'T2. Grundlagen zur Verwaltung von Daten in IT-Systemen',2),
 (5803,5500,'T3. Grundlagen der Softwareentwicklung',3),
 (5804,5500,'T4. Einfache Anwendungen zur Datenverarbeitung programmieren',4),
 (5805,5500,'T5. Anwendungen zur Verwaltung von Daten in Dateien entwickeln',5),
 (5806,5500,'T6. Anwendungen zur Verwaltung von Daten in Datenbanken',6),
 (5807,5500,'T7. Software testen und dokumentieren',7);

INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (5801,5801,'T1. Umfeld der Softwareentwicklung analysieren','Rollen, Lebenszyklus, Softwarearten','<p>(Platzhalter)</p>'),
 (5802,5802,'T2. Grundlagen Datenverwaltung','Daten vs. Information, Darstellung','<p>(Platzhalter)</p>'),
 (5803,5803,'T3. Grundlagen Softwareentwicklung','Modelle, Paradigmen, Tools','<p>(Platzhalter)</p>'),
 (5804,5804,'T4. Einfache Anwendungen','Basis-Programmierung & Strukturen','<p>(Platzhalter)</p>'),
 (5805,5805,'T5. Dateibasierte Datenverwaltung','Formate & Verarbeitung','<p>(Platzhalter)</p>'),
 (5806,5806,'T6. Datenbanken & CRUD','Relationale DB & SQL Basics','<p>(Platzhalter)</p>'),
 (5807,5807,'T7. Testen & Dokumentieren','Tests & Doku-Artefakte','<p>(Platzhalter)</p>');
COMMIT;
