-- LF2 Flashcards (starter set new structure)
BEGIN TRANSACTION;
DELETE FROM flashcards WHERE unit_id BETWEEN 2801 AND 2812;
INSERT INTO flashcards(unit_id,question,answer,difficulty) VALUES
-- 2801 Überblick
(2801,'Ziel von LF2 in einem Satz?','Arbeitsplätze kundenorientiert ausstatten',1),
(2801,'Fünf Phasen (Reihenfolge)?','Analyse → Auswahl → Beschaffung → Installation → Übergabe',2),
(2801,'Wozu Lernsituationen 1–5?','Abbilden des realen Ablaufprozesses',1),
(2801,'Was wird analysiert vor Auswahl?','Bedarf / Anforderungen des Kunden',1),
(2801,'Kundenorientierung bedeutet?','Lösung passt fachlich, wirtschaftlich und nutzerfreundlich',2),
-- 2802 Einsatzbereiche
(2802,'Vier typische Einsatzbereiche?','Büro, Homeoffice, Außendienst, Produktion',1),
(2802,'Industrie 4.0 Kerngedanke?','Vernetzte, selbststeuernde Systeme/Sensoren',2),
(2802,'Remote-Arbeit Sicherheitsbaustein?','VPN mit gesichertem Endgerät',1),
(2802,'Warum unterscheiden sich HW-Anforderungen je Bereich?','Umgebung & Nutzungsszenarien differieren',2),
-- 2803 Agile Büros
(2803,'Vorteil Kombibüro?','Balance aus Fokus und Austausch',1),
(2803,'Non-territorial Hauptmerkmal?','Kein fester Arbeitsplatz (Desk Sharing)',1),
(2803,'Ergonomie Beispielmaßnahme?','Höhenverstellbarer Tisch / gute Beleuchtung',1),
(2803,'Warum agile Räume?','Fördern Teamarbeit & flexible Projekte',2),
-- 2804 Bauformen
(2804,'Workstation Einsatzfall?','CAD / Rendering / High-End Aufgaben',1),
(2804,'Mini-PC Vorteil?','Platz- & Energieersparnis',1),
(2804,'All-in-One Nachteil?','Geringere Aufrüstbarkeit',2),
(2804,'Notebook Vorteil für Außendienst?','Mobilität / flexibler Einsatz',1),
-- 2805 Client-Konzepte
(2805,'Thin Client Kernprinzip?','Ausführung auf Server / zentrales Rechenzentrum',1),
(2805,'Zero Client Unterschied?','Noch schlanker, bootet direkt ins Protokoll / Firmware',2),
(2805,'Cloud Client Vorteil?','Überall nutzbar (DaaS)',1),
(2805,'Beispiel spezielles Thin-OS?','Igel / HP ThinPro',1),
-- 2806 Virtualisierung
(2806,'RDS / VDI Vorteil?','Zentrale Verwaltung & Sicherheit',1),
(2806,'HCI steht für?','Hyper-Converged Infrastructure',2),
(2806,'Nachteil VDI?','Netzwerkabhängigkeit / Latenz',1),
(2806,'Connection Broker Aufgabe?','Session-Zuordnung / Lastverteilung',2),
-- 2807 Komponenten
(2807,'CPU Kennzahlen?','Kerne, Takt, Cache',1),
(2807,'RAM Bedeutung?','Ermöglicht paralleles Arbeiten / Multitasking',1),
(2807,'SSD Vorteil ggü HDD?','Höhere Geschwindigkeit / geringere Latenz',1),
(2807,'Warum Kundenanforderungen beachten?','Verhindert Unter-/Überdimensionierung',2),
-- 2808 Anforderungsanalyse
(2808,'Erstes Vorgehen vor Beschaffung?','Anforderungen erheben',1),
(2808,'Inhalt Kurz-Pflichtenheft?','Hard-/Software, Leistung, Schnittstellen',1),
(2808,'Zweck Dokumentation?','Transparenz & Freigabe',1),
(2808,'Werkzeug zur Priorisierung?','MoSCoW / Checkliste',2),
-- 2809 Beschaffung
(2809,'TCO Bedeutung?','Total Cost of Ownership',1),
(2809,'Warum Angebote vergleichen?','Wirtschaftlichkeit & Eignung sichern',1),
(2809,'Lieferantenauswahl Kriterium?','Service/SLA + Preis/Leistung',2),
(2809,'Schritt nach Vergleich?','Bestellung / Auftrag',1),
-- 2810 Lieferung & Übergabe
(2810,'Wesentlicher Installationsschritt?','OS + Treiber Installation',1),
(2810,'Dokument am Ende?','Abnahmeprotokoll',1),
(2810,'Warum Rechtekonzept?','Sicherheit & Rollenabgrenzung',2),
(2810,'Einweisung Zweck?','Nutzer befähigen & Akzeptanz sichern',1),
-- 2811 Betrieb
(2811,'Beispiel Managed Service?','Monitoring / Patch Management',1),
(2811,'Grund für Backups?','Datenwiederherstellung & Schutz',1),
(2811,'Patch Management Ziel?','Schließen von Sicherheitslücken',2),
(2811,'Outsourcing Vorteil?','Fokus auf Kernkompetenzen',2),
-- 2812 Peripherie
(2812,'Cloud Printing Vorteil?','Ortsunabhängiges Drucken',1),
(2812,'VPN-Drucken nötig wann?','Außendienst / Remote',1),
(2812,'Treiber/Protokoll Beispiel?','IPP / WSD / SMB',1),
(2812,'Kostenaspekt Druck?','Verbrauch + Wartung',2);
COMMIT;
