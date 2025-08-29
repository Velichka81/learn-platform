-- LF2 Quiz placeholder (old quiz removed pending new authoring for AP2 structure)
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE unit_id BETWEEN 201 AND 224);
DELETE FROM questions WHERE unit_id BETWEEN 201 AND 224;

-- Grundsatz: pro ausgewählter Unit 4-5 Fragen (sc/tf/mc/gap) – erweiterbar
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(201,'sc','Welche Phase kommt unmittelbar nach der Analyse?','Ablauf laut Modell: Auswahl.'),
(201,'tf','Lernsituationen 1–5 bilden den realen Prozess von Portfolio bis Übergabe ab. (R/F)','Richtig.'),
(201,'mc','Bestandteile der kundenorientierten Arbeitsplatzgestaltung? (Mehrfachauswahl)','Analyse, Auswahl, Beschaffung, Installation, Übergabe.'),
(201,'gap','Ziel von LF2 ist Arbeitsplätze ____ auszustatten.','kundenorientiert'),
-- Einsatzbereiche
(207,'sc','Welcher Bereich stellt erhöhte Umweltanforderungen an Hardware?','Produktion/Industrie.'),
(207,'tf','Homeoffice braucht keine besonderen Sicherheitsmaßnahmen. (R/F)','Falsch: VPN u.a. nötig.'),
(207,'mc','Typische Einsatzbereiche (Mehrfachauswahl)','Büro, Homeoffice, Außendienst, Produktion.'),
(207,'gap','Industrie 4.0 verbindet Maschinen über ____ Systeme.','vernetzte'),
-- Agile Büros
(209,'sc','Welches Konzept kombiniert Rückzug und Austausch?','Kombibüro.'),
(209,'tf','Non-territorial bedeutet fester persönlicher Arbeitsplatz. (R/F)','Falsch.'),
(209,'mc','Ergonomiefaktoren (Mehrfachauswahl)','Licht, Akustik, Klima.'),
(209,'gap','Desk Sharing = ____ Arbeitsplatzzuordnung.','keine feste'),
-- Bauformen
(211,'sc','Welche Bauform eignet sich für CAD?','Workstation.'),
(211,'tf','Mini-PCs sind meist leistungsstärker als High-End Workstations. (R/F)','Falsch.'),
(211,'mc','Mobile Varianten (Mehrfachauswahl)','Notebook, Convertible, Tablet.'),
(211,'gap','All-in-One vereint Rechner und _____.','Bildschirm'),
-- Client-Konzepte
(213,'sc','Thin Clients verarbeiten Anwendungen primär _____.','serverseitig'),
(213,'tf','Zero Clients haben oft vollwertiges lokales OS. (R/F)','Falsch.'),
(213,'mc','Konzepte (Mehrfachauswahl)','Thin Client, Zero Client, Cloud Client.'),
(213,'gap','DaaS steht für Desktop as a _____.','Service'),
-- Virtualisierung
(216,'sc','Aufgabe eines Connection Brokers?','Session-Zuordnung & Laststeuerung.'),
(216,'tf','VDI reduziert Anforderungen an Netzwerk vollständig. (R/F)','Falsch: Abhängigkeit bleibt.'),
(216,'mc','Vorteile VDI (Mehrfachauswahl)','Zentrale Verwaltung, Sicherheit, Skalierbarkeit.'),
(216,'gap','HCI ausgeschrieben: Hyper-_____ Infrastructure.','Converged'),
-- Komponenten
(218,'sc','Welche Komponente bestimmt primär Multitasking-Fähigkeit?','RAM.'),
(218,'tf','NVMe ist langsamer als HDD. (R/F)','Falsch: deutlich schneller.'),
(218,'mc','Leistungskomponenten (Mehrfachauswahl)','CPU, RAM, Storage.'),
(218,'gap','Grafik kann onboard oder _____ sein.','dediziert'),
-- Anforderungsanalyse
(220,'sc','Welches Dokument bündelt Anforderungen kompakt?','Kurz-Pflichtenheft.'),
(220,'tf','Anforderungen werden nach der Bestellung erhoben. (R/F)','Falsch: vorher.'),
(220,'mc','Methoden der Analyse (Mehrfachauswahl)','Interview, Checkliste, Use-Cases.'),
(220,'gap','Priorisierungstechnik: MoSCoW ordnet Muss/Soll/Kann und _____.','Wird-nicht'),
-- Beschaffung
(221,'sc','TCO betrachtet neben Anschaffung auch _____.','Betriebskosten.'),
(221,'tf','Lieferantenauswahl ignoriert Service-Aspekte. (R/F)','Falsch.'),
(221,'mc','Vergleichskriterien (Mehrfachauswahl)','Preis, Leistung, Service/SLA.'),
(221,'gap','TCO ausgeschrieben: Total Cost of _____.','Ownership'),
-- Lieferung/Installation
(222,'sc','Was folgt typischerweise nach OS-Installation?','Treiber / Netzwerkanbindung.'),
(222,'tf','Benutzerrechte sind für Sicherheit unerheblich. (R/F)','Falsch.'),
(222,'mc','Rollout-Schritte (Mehrfachauswahl)','Hardware-Aufbau, OS & Treiber, Abnahme.'),
(222,'gap','Dokument am Ende: ____protokoll.','Abnahme'),
-- Betrieb
(223,'sc','Patch Management Ziel?','Schließen von Sicherheitslücken.'),
(223,'tf','Backups sind nach Übergabe optional. (R/F)','Falsch: essentiell.'),
(223,'mc','Managed Services Beispiele (Mehrfachauswahl)','Monitoring, Helpdesk, Backup.'),
(223,'gap','24/7 Betrieb unterstützt hohe _____.','Verfügbarkeit'),
-- Peripherie
(224,'sc','Welches Konzept erlaubt ortsunabhängiges Drucken?','Cloud Printing.'),
(224,'tf','VPN-Drucken unterstützt Außendienst. (R/F)','Richtig.'),
(224,'mc','Kostenfaktoren Drucken (Mehrfachauswahl)','Verbrauch, Wartung, Hardware.'),
(224,'gap','Protokoll-Beispiel: IPP oder _____.','WSD');

-- Options (generate for sc/tf/mc)
-- Note: Using subselect pattern like LF1
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=201 AND type='sc' LIMIT 1),'Auswahl',1),
((SELECT id FROM questions WHERE unit_id=201 AND type='sc' LIMIT 1),'Beschaffung',0),
((SELECT id FROM questions WHERE unit_id=201 AND type='sc' LIMIT 1),'Übergabe',0),
((SELECT id FROM questions WHERE unit_id=201 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=201 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=201 AND type='mc' LIMIT 1),'Analyse',1),
((SELECT id FROM questions WHERE unit_id=201 AND type='mc' LIMIT 1),'Auswahl',1),
((SELECT id FROM questions WHERE unit_id=201 AND type='mc' LIMIT 1),'Beschaffung',1),
((SELECT id FROM questions WHERE unit_id=201 AND type='mc' LIMIT 1),'Installation',1),
((SELECT id FROM questions WHERE unit_id=201 AND type='mc' LIMIT 1),'Übergabe',1),
-- 207
((SELECT id FROM questions WHERE unit_id=207 AND type='sc' LIMIT 1),'Produktion',1),
((SELECT id FROM questions WHERE unit_id=207 AND type='sc' LIMIT 1),'Büro',0),
((SELECT id FROM questions WHERE unit_id=207 AND type='sc' LIMIT 1),'Homeoffice',0),
((SELECT id FROM questions WHERE unit_id=207 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=207 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=207 AND type='mc' LIMIT 1),'Büro',1),
((SELECT id FROM questions WHERE unit_id=207 AND type='mc' LIMIT 1),'Homeoffice',1),
((SELECT id FROM questions WHERE unit_id=207 AND type='mc' LIMIT 1),'Außendienst',1),
((SELECT id FROM questions WHERE unit_id=207 AND type='mc' LIMIT 1),'Produktion',1),
-- 209
((SELECT id FROM questions WHERE unit_id=209 AND type='sc' LIMIT 1),'Kombibüro',1),
((SELECT id FROM questions WHERE unit_id=209 AND type='sc' LIMIT 1),'Zellenbüro',0),
((SELECT id FROM questions WHERE unit_id=209 AND type='sc' LIMIT 1),'Großraum',0),
((SELECT id FROM questions WHERE unit_id=209 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=209 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=209 AND type='mc' LIMIT 1),'Licht',1),
((SELECT id FROM questions WHERE unit_id=209 AND type='mc' LIMIT 1),'Akustik',1),
((SELECT id FROM questions WHERE unit_id=209 AND type='mc' LIMIT 1),'Klima',1),
((SELECT id FROM questions WHERE unit_id=209 AND type='mc' LIMIT 1),'Privatauto',0),
-- 211
((SELECT id FROM questions WHERE unit_id=211 AND type='sc' LIMIT 1),'Workstation',1),
((SELECT id FROM questions WHERE unit_id=211 AND type='sc' LIMIT 1),'Mini-PC',0),
((SELECT id FROM questions WHERE unit_id=211 AND type='sc' LIMIT 1),'Stick-PC',0),
((SELECT id FROM questions WHERE unit_id=211 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=211 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=211 AND type='mc' LIMIT 1),'Notebook',1),
((SELECT id FROM questions WHERE unit_id=211 AND type='mc' LIMIT 1),'Convertible',1),
((SELECT id FROM questions WHERE unit_id=211 AND type='mc' LIMIT 1),'Tablet',1),
((SELECT id FROM questions WHERE unit_id=211 AND type='mc' LIMIT 1),'Tower nur',0),
-- 213
((SELECT id FROM questions WHERE unit_id=213 AND type='sc' LIMIT 1),'serverseitig',1),
((SELECT id FROM questions WHERE unit_id=213 AND type='sc' LIMIT 1),'lokal',0),
((SELECT id FROM questions WHERE unit_id=213 AND type='sc' LIMIT 1),'Edge',0),
((SELECT id FROM questions WHERE unit_id=213 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=213 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=213 AND type='mc' LIMIT 1),'Thin Client',1),
((SELECT id FROM questions WHERE unit_id=213 AND type='mc' LIMIT 1),'Zero Client',1),
((SELECT id FROM questions WHERE unit_id=213 AND type='mc' LIMIT 1),'Cloud Client',1),
((SELECT id FROM questions WHERE unit_id=213 AND type='mc' LIMIT 1),'Diskettenclient',0),
-- 216
((SELECT id FROM questions WHERE unit_id=216 AND type='sc' LIMIT 1),'Session-Zuordnung & Laststeuerung',1),
((SELECT id FROM questions WHERE unit_id=216 AND type='sc' LIMIT 1),'Benutzerverwaltung lokal',0),
((SELECT id FROM questions WHERE unit_id=216 AND type='sc' LIMIT 1),'Backup',0),
((SELECT id FROM questions WHERE unit_id=216 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=216 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=216 AND type='mc' LIMIT 1),'Zentrale Verwaltung',1),
((SELECT id FROM questions WHERE unit_id=216 AND type='mc' LIMIT 1),'Sicherheit',1),
((SELECT id FROM questions WHERE unit_id=216 AND type='mc' LIMIT 1),'Skalierbarkeit',1),
((SELECT id FROM questions WHERE unit_id=216 AND type='mc' LIMIT 1),'Hohe Latenz (positiv)',0),
-- 218
((SELECT id FROM questions WHERE unit_id=218 AND type='sc' LIMIT 1),'RAM',1),
((SELECT id FROM questions WHERE unit_id=218 AND type='sc' LIMIT 1),'GPU',0),
((SELECT id FROM questions WHERE unit_id=218 AND type='sc' LIMIT 1),'Mainboardfarbe',0),
((SELECT id FROM questions WHERE unit_id=218 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=218 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=218 AND type='mc' LIMIT 1),'CPU',1),
((SELECT id FROM questions WHERE unit_id=218 AND type='mc' LIMIT 1),'RAM',1),
((SELECT id FROM questions WHERE unit_id=218 AND type='mc' LIMIT 1),'Storage',1),
((SELECT id FROM questions WHERE unit_id=218 AND type='mc' LIMIT 1),'RGB Beleuchtung',0),
-- 220
((SELECT id FROM questions WHERE unit_id=220 AND type='sc' LIMIT 1),'Kurz-Pflichtenheft',1),
((SELECT id FROM questions WHERE unit_id=220 AND type='sc' LIMIT 1),'Abnahmeprotokoll',0),
((SELECT id FROM questions WHERE unit_id=220 AND type='sc' LIMIT 1),'Rechnung',0),
((SELECT id FROM questions WHERE unit_id=220 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=220 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=220 AND type='mc' LIMIT 1),'Interview',1),
((SELECT id FROM questions WHERE unit_id=220 AND type='mc' LIMIT 1),'Checkliste',1),
((SELECT id FROM questions WHERE unit_id=220 AND type='mc' LIMIT 1),'Use-Cases',1),
((SELECT id FROM questions WHERE unit_id=220 AND type='mc' LIMIT 1),'Zufallsprinzip',0),
-- 221
((SELECT id FROM questions WHERE unit_id=221 AND type='sc' LIMIT 1),'Betriebskosten',1),
((SELECT id FROM questions WHERE unit_id=221 AND type='sc' LIMIT 1),'Farbschema',0),
((SELECT id FROM questions WHERE unit_id=221 AND type='sc' LIMIT 1),'Social Media Likes',0),
((SELECT id FROM questions WHERE unit_id=221 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=221 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=221 AND type='mc' LIMIT 1),'Preis',1),
((SELECT id FROM questions WHERE unit_id=221 AND type='mc' LIMIT 1),'Leistung',1),
((SELECT id FROM questions WHERE unit_id=221 AND type='mc' LIMIT 1),'Service/SLA',1),
((SELECT id FROM questions WHERE unit_id=221 AND type='mc' LIMIT 1),'Wetterlage',0),
-- 222
((SELECT id FROM questions WHERE unit_id=222 AND type='sc' LIMIT 1),'Treiber / Netz',1),
((SELECT id FROM questions WHERE unit_id=222 AND type='sc' LIMIT 1),'Abnahme zuerst',0),
((SELECT id FROM questions WHERE unit_id=222 AND type='sc' LIMIT 1),'Backup initial',0),
((SELECT id FROM questions WHERE unit_id=222 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=222 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=222 AND type='mc' LIMIT 1),'Hardware-Aufbau',1),
((SELECT id FROM questions WHERE unit_id=222 AND type='mc' LIMIT 1),'OS & Treiber',1),
((SELECT id FROM questions WHERE unit_id=222 AND type='mc' LIMIT 1),'Abnahme',1),
((SELECT id FROM questions WHERE unit_id=222 AND type='mc' LIMIT 1),'Privatsoftware',0),
-- 223
((SELECT id FROM questions WHERE unit_id=223 AND type='sc' LIMIT 1),'Schließen von Sicherheitslücken',1),
((SELECT id FROM questions WHERE unit_id=223 AND type='sc' LIMIT 1),'Umsatzerhöhung Marketing',0),
((SELECT id FROM questions WHERE unit_id=223 AND type='sc' LIMIT 1),'Designverbesserung',0),
((SELECT id FROM questions WHERE unit_id=223 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=223 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=223 AND type='mc' LIMIT 1),'Monitoring',1),
((SELECT id FROM questions WHERE unit_id=223 AND type='mc' LIMIT 1),'Helpdesk',1),
((SELECT id FROM questions WHERE unit_id=223 AND type='mc' LIMIT 1),'Backup',1),
((SELECT id FROM questions WHERE unit_id=223 AND type='mc' LIMIT 1),'Kantinenplanung',0),
-- 224
((SELECT id FROM questions WHERE unit_id=224 AND type='sc' LIMIT 1),'Cloud Printing',1),
((SELECT id FROM questions WHERE unit_id=224 AND type='sc' LIMIT 1),'Handdruck',0),
((SELECT id FROM questions WHERE unit_id=224 AND type='sc' LIMIT 1),'Fax-Only',0),
((SELECT id FROM questions WHERE unit_id=224 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=224 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=224 AND type='mc' LIMIT 1),'Verbrauch',1),
((SELECT id FROM questions WHERE unit_id=224 AND type='mc' LIMIT 1),'Wartung',1),
((SELECT id FROM questions WHERE unit_id=224 AND type='mc' LIMIT 1),'Hardware',1),
((SELECT id FROM questions WHERE unit_id=224 AND type='mc' LIMIT 1),'Lieblingsfarbe',0);

COMMIT;
