-- LF2 Strukturvereinfachung: ein Kapitel wie LF1 (Topics/Units T1..T12)
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=2002));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=2002);
DELETE FROM chapters WHERE learning_field_id=2002;
DELETE FROM learning_fields WHERE id=2002;

INSERT INTO learning_fields(id,code,title,exam_phase,position) VALUES (2002,'LF2','Arbeitsplätze nach Kundenwunsch ausstatten','AP2',2);
INSERT INTO chapters(id,learning_field_id,title,position) VALUES (2200,2002,'LF2: Arbeitsplätze nach Kundenwunsch ausstatten',1);

INSERT INTO topics(id,chapter_id,title,position) VALUES
 (2801,2200,'T1. Überblick & Lernsituationen',1),
 (2802,2200,'T2. Einsatzbereiche & Arbeitsumgebungen',2),
 (2803,2200,'T3. Agile Büroumgebungen & Konzepte',3),
 (2804,2200,'T4. Arbeitsplatzvarianten & Bauformen',4),
 (2805,2200,'T5. Client-Konzepte & Betriebssysteme',5),
 (2806,2200,'T6. Remote Desktop & Virtualisierung',6),
 (2807,2200,'T7. Auswahlkriterien & Komponenten',7),
 (2808,2200,'T8. Anforderungsanalyse & Pflichtenheft',8),
 (2809,2200,'T9. Beschaffungsvorgänge',9),
 (2810,2200,'T10. Lieferung & Installation',10),
 (2811,2200,'T11. Managed-IT-Services & Betrieb',11),
 (2812,2200,'T12. Peripherie & Druckkonzepte',12);

INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (2801,2801,'T1. Überblick & Lernsituationen','Überblick & Ziele','<p>(Platzhalter)</p>'),
 (2802,2802,'T2. Einsatzbereiche & Arbeitsumgebungen','Arbeitsorte & Szenarien','<p>(Platzhalter)</p>'),
 (2803,2803,'T3. Agile Büroumgebungen & Konzepte','Arbeitsplatzformen & Agilität','<p>(Platzhalter)</p>'),
 (2804,2804,'T4. Arbeitsplatzvarianten & Bauformen','Varianten & Geräte','<p>(Platzhalter)</p>'),
 (2805,2805,'T5. Client-Konzepte & Betriebssysteme','Konzepte & OS','<p>(Platzhalter)</p>'),
 (2806,2806,'T6. Remote Desktop & Virtualisierung','RDS / VDI Basics','<p>(Platzhalter)</p>'),
 (2807,2807,'T7. Auswahlkriterien & Komponenten','CPU / RAM / Storage','<p>(Platzhalter)</p>'),
 (2808,2808,'T8. Anforderungsanalyse & Pflichtenheft','Bedarf & Dokumentation','<p>(Platzhalter)</p>'),
 (2809,2809,'T9. Beschaffungsvorgänge','Beschaffungsablauf','<p>(Platzhalter)</p>'),
 (2810,2810,'T10. Lieferung & Installation','Rollout & Übergabe','<p>(Platzhalter)</p>'),
 (2811,2811,'T11. Managed-IT-Services & Betrieb','Service & Betrieb','<p>(Platzhalter)</p>'),
 (2812,2812,'T12. Peripherie & Druckkonzepte','Druck & Peripherie','<p>(Platzhalter)</p>');
COMMIT;
