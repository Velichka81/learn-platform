-- LF6 Struktur (ein Kapitel, 7 Topics/Units T1..T7)
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=6006));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=6006);
DELETE FROM chapters WHERE learning_field_id=6006;
DELETE FROM learning_fields WHERE id=6006;

INSERT INTO learning_fields(id,code,title,exam_phase,position) VALUES (6006,'LF6','Das Unternehmen und die eigene Rolle im Betrieb beschreiben','AP1',6);
INSERT INTO chapters(id,learning_field_id,title,position) VALUES (6600,6006,'LF6: Das Unternehmen und die eigene Rolle im Betrieb beschreiben',1);

-- Topics / Units (Topic-ID == Unit-ID)
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (6801,6600,'T1. Eigene Rolle im Betrieb',1),
 (6802,6600,'T2. Ausbildungsbetrieb beschreiben & präsentieren',2),
 (6803,6600,'T3. Rechte und Pflichten in der Ausbildung',3),
 (6804,6600,'T4. Betriebliche Organisation & Prozesse',4),
 (6805,6600,'T5. Marktpotenzial & Leistungsangebot',5),
 (6806,6600,'T6. Zusammenarbeit im Betrieb',6),
 (6807,6600,'T7. Zukunftsperspektiven & persönliche Entwicklung',7);

INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (6801,6801,'T1. Eigene Rolle im Betrieb','Aufgaben, Verantwortung, Teamarbeit','<p>(Platzhalter)</p>'),
 (6802,6802,'T2. Ausbildungsbetrieb beschreiben & präsentieren','Geschichte, Struktur, Angebot','<p>(Platzhalter)</p>'),
 (6803,6803,'T3. Rechte und Pflichten in der Ausbildung','BBiG – Vertiefung','<p>(Platzhalter)</p>'),
 (6804,6804,'T4. Betriebliche Organisation & Prozesse','Aufbau- und Ablauforganisation','<p>(Platzhalter)</p>'),
 (6805,6805,'T5. Marktpotenzial & Leistungsangebot','Produkte, Kunden, Wettbewerb','<p>(Platzhalter)</p>'),
 (6806,6806,'T6. Zusammenarbeit im Betrieb','Kommunikation & Soft Skills','<p>(Platzhalter)</p>'),
 (6807,6807,'T7. Zukunftsperspektiven & persönliche Entwicklung','Karriere & Weiterbildung','<p>(Platzhalter)</p>');
COMMIT;
