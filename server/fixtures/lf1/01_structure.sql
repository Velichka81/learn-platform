-- LF1 Structure Seed (Learning Field, Chapter, Topics, Units placeholders)
-- Idempotent: removes existing LF1 (id=1001) subtree first
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=1001));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=1001);
DELETE FROM chapters WHERE learning_field_id=1001;
DELETE FROM learning_fields WHERE id=1001;

INSERT INTO learning_fields(id,code,title,exam_phase,position) VALUES (1001,'LF1','Das Unternehmen und die eigene Rolle im Betrieb beschreiben','AP1',1);
INSERT INTO chapters(id,learning_field_id,title,position) VALUES (1,1001,'LF1: Das Unternehmen und die eigene Rolle im Betrieb',1);

-- Topics / Units (T1..T10). Topic id == Unit id for simplicity.
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (1,1,'T1. IT-Ausbildungsberufe & duales System (Überblick)',1),
 (2,1,'T2. Gestreckte Abschlussprüfung & Zeugnisse',2),
 (3,1,'T3. Rechte & Pflichten / Ausbildungsvertrag',3),
 (4,1,'T4. Jugendarbeitsschutz',4),
 (5,1,'T5. Vergütung, Abzüge & Teilzeit',5),
 (6,1,'T6. Arbeitsrecht-Basics',6),
 (7,1,'T7. Mitbestimmung & Tarif',7),
 (8,1,'T8. JAV',8),
 (9,1,'T9. Präsentation des Betriebs',9),
 (10,1,'T10. Ausbildungsplan & Rotation',10);

-- Bare units (content added in 02_content.sql)
INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (1,1,'T1. IT-Ausbildungsberufe & duales System','Überblick duales System','<p>(Platzhalter)</p>'),
 (2,2,'T2. Gestreckte Abschlussprüfung & Zeugnisse','Prüfungsstruktur AP1/AP2','<p>(Platzhalter)</p>'),
 (3,3,'T3. Rechte & Pflichten / Ausbildungsvertrag','BBiG Grundlagen','<p>(Platzhalter)</p>'),
 (4,4,'T4. Jugendarbeitsschutz','Schutzvorschriften Jugendliche','<p>(Platzhalter)</p>'),
 (5,5,'T5. Vergütung, Abzüge & Teilzeit','Vergütung & Teilzeit','<p>(Platzhalter)</p>'),
 (6,6,'T6. Arbeitsrecht-Basics','Zentrale Gesetze','<p>(Platzhalter)</p>'),
 (7,7,'T7. Mitbestimmung & Tarif','BR & Tarif','<p>(Platzhalter)</p>'),
 (8,8,'T8. JAV','Jugend- und Auszubildendenvertretung','<p>(Platzhalter)</p>'),
 (9,9,'T9. Präsentation des Betriebs','Präsentation planen','<p>(Platzhalter)</p>'),
 (10,10,'T10. Ausbildungsplan & Rotation','Plan & Rotation','<p>(Platzhalter)</p>');
COMMIT;
