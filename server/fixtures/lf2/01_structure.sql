-- Rebuild LF2 to new AP2 thematic structure: Arbeitsplätze nach Kundenwunsch ausstatten
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
-- Wipe previous LF2 subtree (id=2002)
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=2002));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=2002);
DELETE FROM chapters WHERE learning_field_id=2002;
DELETE FROM learning_fields WHERE id=2002;

INSERT INTO learning_fields(id,code,title,exam_phase,position)
VALUES (2002,'LF2','Arbeitsplätze nach Kundenwunsch ausstatten','AP2',2);

-- Chapters
-- 12 Kapitel Variante (jede Nummer = eigenes Kapitel)
INSERT INTO chapters(id,learning_field_id,title,position) VALUES
 (2201,2002,'1. Überblick & Lernsituationen',1),
 (2202,2002,'2. Einsatzbereiche & Arbeitsumgebungen',2),
 (2203,2002,'3. Agile Büroumgebungen & Konzepte',3),
 (2204,2002,'4. Arbeitsplatzvarianten & Bauformen',4),
 (2205,2002,'5. Client-Konzepte & Betriebssysteme',5),
 (2206,2002,'6. Remote Desktop & Virtualisierung',6),
 (2207,2002,'7. Auswahlkriterien & Komponenten',7),
 (2208,2002,'8. Anforderungsanalyse & Pflichtenheft',8),
 (2209,2002,'9. Beschaffungsvorgänge',9),
 (2210,2002,'10. Lieferung & Installation',10),
 (2211,2002,'11. Managed-IT-Services & Betrieb',11),
 (2212,2002,'12. Peripherie & Druckkonzepte',12);

-- One topic per chapter (simplified)
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (2301,2201,'Überblick & Lernsituationen',1),
 (2302,2202,'Einsatzbereiche & Arbeitsrealität',1),
 (2303,2203,'Büroumgebungen & Konzepte',1),
 (2304,2204,'Varianten & Konfiguration',1),
 (2305,2205,'Client-Konzepte & OS',1),
 (2306,2206,'Virtualisierung & Bewertung',1),
 (2307,2207,'Komponenten & Kriterien',1),
 (2308,2208,'Anforderungsanalyse',1),
 (2309,2209,'Beschaffung',1),
 (2310,2210,'Lieferung & Installation',1),
 (2311,2211,'Betrieb & Services',1),
 (2312,2212,'Peripherie & Druck',1);

-- Units reassigned to new single-topic chapters
INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (201,2301,'Überblick & Ziel / Leistungsportfolio','Ziele & Angebotssystem','<p>(Platzhalter)</p>'),
 (202,2301,'Lernsituation 1: Leistungsportfolio erkunden','Portfolio analysieren','<p>(Platzhalter)</p>'),
 (203,2301,'Lernsituation 2: Auswahlkriterien & technische Merkmale','Kriterien definieren','<p>(Platzhalter)</p>'),
 (204,2301,'Lernsituation 3: Anforderungsanalyse','Bedarf erfassen','<p>(Platzhalter)</p>'),
 (205,2301,'Lernsituation 4: Beschaffung','Von Analyse zu Angebot','<p>(Platzhalter)</p>'),
 (206,2301,'Lernsituation 5: Lieferung / Installation / Übergabe','Rollout & Übergabe','<p>(Platzhalter)</p>'),
 (207,2302,'Einsatzbereiche & Arbeitsumgebungen','Innen / Außen / Home / IoT','<p>(Platzhalter)</p>'),
 (208,2302,'Heutige Arbeitsrealität','Virtuelle Teams & Industrie 4.0','<p>(Platzhalter)</p>'),
 (209,2303,'Kommunikative & agile Büroumgebungen','Ergonomie & Gesundheit','<p>(Platzhalter)</p>'),
 (210,2303,'Bürokonzepte','Zellen / Großraum / Kombi etc.','<p>(Platzhalter)</p>'),
 (211,2304,'Arbeitsplatzvarianten & Bauformen','Desktop bis Smart Device','<p>(Platzhalter)</p>'),
 (212,2304,'Arbeitsplatzvarianten & Konfiguration','Konfigurationsübersicht','<p>(Platzhalter)</p>'),
 (213,2305,'Client-Konzepte','Thin / Zero / Cloud / AIO','<p>(Platzhalter)</p>'),
 (214,2305,'Client-Betriebssysteme & Thin-Client-OS','Linux / Windows / Igel','<p>(Platzhalter)</p>'),
 (215,2305,'Browser-/Remote-/Virtual Delivery','HTML5 / RDP / HDX','<p>(Platzhalter)</p>'),
 (216,2306,'Remote Desktop & Virtualisierung','RDS / VDI / HCI','<p>(Platzhalter)</p>'),
 (217,2306,'Vorteile/Nachteile & Sicherheit/Lizenz','Bewertung & Risiken','<p>(Platzhalter)</p>'),
 (218,2307,'Auswahlkriterien & Komponenten','CPU / RAM / Storage','<p>(Platzhalter)</p>'),
 (219,2307,'Komponenten unterscheiden','Vergleich & Matrix','<p>(Platzhalter)</p>'),
 (220,2308,'Anforderungsanalyse & (Kurz-)Pflichtenheft','Dokumentation Bedarf','<p>(Platzhalter)</p>'),
 (221,2309,'Beschaffungsvorgänge durchführen','Markt & Portfolio Abgleich','<p>(Platzhalter)</p>'),
 (222,2310,'Lieferung, Installation, Übergabe & Einweisung','Aufbau & Abnahme','<p>(Platzhalter)</p>'),
 (223,2311,'Managed-IT-Services & Betrieb','Betrieb & Support','<p>(Platzhalter)</p>'),
 (224,2312,'Peripherie & Druckkonzepte','Cloud / VPN / Abteilung','<p>(Platzhalter)</p>');
COMMIT;
