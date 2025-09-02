-- LF4 Struktur neu wie LF1 (ein Kapitel, durchnummerierte Topics/Units T1..T9)
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=4004));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=4004);
DELETE FROM chapters WHERE learning_field_id=4004;
DELETE FROM learning_fields WHERE id=4004;

INSERT INTO learning_fields(id,code,title,exam_phase,position) VALUES (4004,'LF4','Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen','AP2',4);
INSERT INTO chapters(id,learning_field_id,title,position) VALUES (4400,4004,'LF4: Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen',1);

-- Topics (T1..T9) – Topic-ID == Unit-ID
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (4801,4400,'T1. Einführung in die Informationssicherheit',1),
 (4802,4400,'T2. Gesetze, Standards und Aufsichtsbehörden',2),
 (4803,4400,'T3. IT-Grundschutz & Schutzziele',3),
 (4804,4400,'T4. Gefährdungen & Schadensszenarien',4),
 (4805,4400,'T5. Der Faktor Mensch',5),
 (4806,4400,'T6. Technisch-organisatorische Maßnahmen (TOMs)',6),
 (4807,4400,'T7. Phasen des Sicherheitsprozesses nach BSI',7),
 (4808,4400,'T8. Beispielunternehmen RECPLAST GmbH (BSI-Beispiel)',8),
 (4809,4400,'T9. Schutzbedarfsfeststellung im eigenen Betrieb',9);

INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (4801,4801,'T1. Einführung in die Informationssicherheit','Grundlagen & Bedeutung','<p>(Platzhalter)</p>'),
 (4802,4802,'T2. Gesetze, Standards und Aufsichtsbehörden','Recht & Aufsicht','<p>(Platzhalter)</p>'),
 (4803,4803,'T3. IT-Grundschutz & Schutzziele','Schutzziele & Methodik','<p>(Platzhalter)</p>'),
 (4804,4804,'T4. Gefährdungen & Schadensszenarien','Gefahren & Schäden','<p>(Platzhalter)</p>'),
 (4805,4805,'T5. Der Faktor Mensch','Mensch als Risiko','<p>(Platzhalter)</p>'),
 (4806,4806,'T6. TOMs','Technisch / organisatorische Maßnahmen','<p>(Platzhalter)</p>'),
 (4807,4807,'T7. Sicherheitsprozess nach BSI','PDCA & Schritte','<p>(Platzhalter)</p>'),
 (4808,4808,'T8. Beispiel RECPLAST','Praxisbeispiel BSI','<p>(Platzhalter)</p>'),
 (4809,4809,'T9. Schutzbedarfsfeststellung Betrieb','Anwendung & Bewertung','<p>(Platzhalter)</p>');
COMMIT;
