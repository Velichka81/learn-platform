-- LF2 Flashcards (starter set new structure)
BEGIN TRANSACTION;
DELETE FROM flashcards WHERE unit_id BETWEEN 201 AND 224;
INSERT INTO flashcards(unit_id,question,answer,difficulty) VALUES
-- 201 Überblick
(201,'Ziel von LF2 in einem Satz?','Arbeitsplätze kundenorientiert ausstatten',1),
(201,'Fünf Phasen (Reihenfolge)?','Analyse → Auswahl → Beschaffung → Installation → Übergabe',2),
(201,'Wozu Lernsituationen 1–5?','Abbilden des realen Ablaufprozesses',1),
(201,'Was wird analysiert vor Auswahl?','Bedarf / Anforderungen des Kunden',1),
(201,'Kundenorientierung bedeutet?','Lösung passt fachlich, wirtschaftlich und nutzerfreundlich',2),
-- 207 Einsatzbereiche
(207,'Vier typische Einsatzbereiche?','Büro, Homeoffice, Außendienst, Produktion',1),
(207,'Industrie 4.0 Kerngedanke?','Vernetzte, selbststeuernde Systeme/Sensoren',2),
(207,'Remote-Arbeit Sicherheitsbaustein?','VPN mit gesichertem Endgerät',1),
(207,'Warum unterscheiden sich HW-Anforderungen je Bereich?','Umgebung & Nutzungsszenarien differieren',2),
-- 209 Agile Büros
(209,'Vorteil Kombibüro?','Balance aus Fokus und Austausch',1),
(209,'Non-territorial Hauptmerkmal?','Kein fester Arbeitsplatz (Desk Sharing)',1),
(209,'Ergonomie Beispielmaßnahme?','Höhenverstellbarer Tisch / gute Beleuchtung',1),
(209,'Warum agile Räume?','Fördern Teamarbeit & flexible Projekte',2),
-- 211 Bauformen
(211,'Workstation Einsatzfall?','CAD / Rendering / High-End Aufgaben',1),
(211,'Mini-PC Vorteil?','Platz- & Energieersparnis',1),
(211,'All-in-One Nachteil?','Geringere Aufrüstbarkeit',2),
(211,'Notebook Vorteil für Außendienst?','Mobilität / flexibler Einsatz',1),
-- 213 Client-Konzepte
(213,'Thin Client Kernprinzip?','Ausführung auf Server / zentrales Rechenzentrum',1),
(213,'Zero Client Unterschied?','Noch schlanker, bootet direkt ins Protokoll / Firmware',2),
(213,'Cloud Client Vorteil?','Überall nutzbar (DaaS)',1),
(213,'Beispiel spezielles Thin-OS?','Igel / HP ThinPro',1),
-- 216 Virtualisierung
(216,'RDS / VDI Vorteil?','Zentrale Verwaltung & Sicherheit',1),
(216,'HCI steht für?','Hyper-Converged Infrastructure',2),
(216,'Nachteil VDI?','Netzwerkabhängigkeit / Latenz',1),
(216,'Connection Broker Aufgabe?','Session-Zuordnung / Lastverteilung',2),
-- 218 Komponenten
(218,'CPU Kennzahlen?','Kerne, Takt, Cache',1),
(218,'RAM Bedeutung?','Ermöglicht paralleles Arbeiten / Multitasking',1),
(218,'SSD Vorteil ggü HDD?','Höhere Geschwindigkeit / geringere Latenz',1),
(218,'Warum Kundenanforderungen beachten?','Verhindert Unter-/Überdimensionierung',2),
-- 220 Anforderungsanalyse
(220,'Erstes Vorgehen vor Beschaffung?','Anforderungen erheben',1),
(220,'Inhalt Kurz-Pflichtenheft?','Hard-/Software, Leistung, Schnittstellen',1),
(220,'Zweck Dokumentation?','Transparenz & Freigabe',1),
(220,'Werkzeug zur Priorisierung?','MoSCoW / Checkliste',2),
-- 221 Beschaffung
(221,'TCO Bedeutung?','Total Cost of Ownership',1),
(221,'Warum Angebote vergleichen?','Wirtschaftlichkeit & Eignung sichern',1),
(221,'Lieferantenauswahl Kriterium?','Service/SLA + Preis/Leistung',2),
(221,'Schritt nach Vergleich?','Bestellung / Auftrag',1),
-- 222 Lieferung & Übergabe
(222,'Wesentlicher Installationsschritt?','OS + Treiber Installation',1),
(222,'Dokument am Ende?','Abnahmeprotokoll',1),
(222,'Warum Rechtekonzept?','Sicherheit & Rollenabgrenzung',2),
(222,'Einweisung Zweck?','Nutzer befähigen & Akzeptanz sichern',1),
-- 223 Betrieb
(223,'Beispiel Managed Service?','Monitoring / Patch Management',1),
(223,'Grund für Backups?','Datenwiederherstellung & Schutz',1),
(223,'Patch Management Ziel?','Schließen von Sicherheitslücken',2),
(223,'Outsourcing Vorteil?','Fokus auf Kernkompetenzen',2),
-- 224 Peripherie
(224,'Cloud Printing Vorteil?','Ortsunabhängiges Drucken',1),
(224,'VPN-Drucken nötig wann?','Außendienst / Remote',1),
(224,'Treiber/Protokoll Beispiel?','IPP / WSD / SMB',1),
(224,'Kostenaspekt Druck?','Verbrauch + Wartung',2);
COMMIT;
