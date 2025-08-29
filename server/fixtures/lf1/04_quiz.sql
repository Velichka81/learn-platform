-- LF1 Quiz Questions (clean set) – builds on earlier spec. Idempotent deletion.
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE unit_id BETWEEN 1 AND 10);
DELETE FROM questions WHERE unit_id BETWEEN 1 AND 10;

-- Example subset (T1 two MC, one SC, one TF, one GAP) – expand pattern per earlier full dataset if needed
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(1,'sc','Vorteil des dualen Systems?','Verzahnung fördert Transfer.'),
(1,'tf','AP Teil 1 prüft Lernfelder 1–6. (R/F)','Richtig: Schwerpunkt umfasst LF1–6.'),
(1,'mc','Beteiligte am Ausbildungsvertrag? (Mehrfachauswahl)','Betrieb, Azubi, IHK registriert.'),
(1,'mc','Direkte Effekte Verzahnung (Mehrfachauswahl)','Schnelle Anwendung, höhere Behaltensrate, Verantwortung.'),
(1,'gap','Zwei Lernorte?','Betrieb und Berufsschule.'),
-- T2
(2,'sc','Dauer & Gewichtung AP Teil 1?','90 Min / 20 %.'),
(2,'tf','AP Teil 2 nur eine Klausur. (R/F)','Falsch: plus Projekt & Gespräch.'),
(2,'mc','Zeugnisse (Mehrfachauswahl)','IHK-, Berufs- und Betriebszeugnis.'),
(2,'gap','Prozentanteil AP1?','20 %.'),
-- T3
(3,'sc','Wer führt das Berichtsheft?','Pflicht Azubi.'),
(3,'tf','Probezeit-Kündigung braucht Grund. (R/F)','Falsch: grundlos möglich.'),
(3,'mc','Pflichten Ausbildender (Mehrfachauswahl)','Ausbilden, Freistellen, Fürsorge.'),
(3,'gap','Ein Vertrags-Mindestinhalt?','Probezeit / Vergütung / Dauer.'),
-- T4
(4,'sc','Max Wochenarbeitszeit Jugendliche?','40h.'),
(4,'tf','Jugendliche regulär 10h/Tag. (R/F)','Falsch: 8h Grundsatz.'),
(4,'mc','Freistellungen (Mehrfachauswahl)','Berufsschule, Prüfungen.'),
(4,'gap','Freier Tag wann?','Vor schriftlicher Abschlussprüfung.'),
-- T5
(5,'sc','Wer führt SV-Beiträge ab?','Arbeitgeber.'),
(5,'tf','Netto = Brutto minus Abzüge. (R/F)','Richtig.'),
(5,'mc','Typische Abzüge (Mehrfachauswahl)','Steuern & Sozialversicherung.'),
(5,'gap','Grund für Teilzeit (§ 8 BBiG)?','Pflege / Betreuung.'),
-- T6
(6,'sc','Was regelt AGG?','Schutz vor Diskriminierung.'),
(6,'tf','MiLoG regelt Mindestlohn. (R/F)','Richtig.'),
(6,'mc','Arbeitsrechtsgesetze (Mehrfachauswahl)','ArbZG, TzBfG, MiLoG.'),
(6,'gap','Günstigkeitsprinzip kurz?','Günstigere Regel gilt.'),
-- T7
(7,'sc','Ab wie vielen MA BR möglich?','5.'),
(7,'tf','Amtszeit BR 6 Jahre. (R/F)','Falsch: 4 Jahre.'),
(7,'mc','Tarifparteien (Mehrfachauswahl)','AG-Verbände, Gewerkschaften.'),
(7,'gap','Wer schließt Tarifverträge?','Gewerkschaften & AG-Verbände.'),
-- T8
(8,'sc','Amtszeit JAV?','2 Jahre.'),
(8,'tf','JAV wählt den BR. (R/F)','Falsch.'),
(8,'mc','Aufgaben JAV (Mehrfachauswahl)','Interessenvertretung, Überwachung, Anregungen.'),
(8,'gap','Partner der JAV?','Betriebsrat.'),
-- T9
(9,'sc','Zielgruppe klären warum?','Inhalte anpassen.'),
(9,'tf','Aufbau Präsentation Einstieg–Hauptteil–Schluss. (R/F)','Richtig.'),
(9,'mc','Hilfsmittel (Mehrfachauswahl)','Folien, Flipchart, Handout.'),
(9,'gap','Zweck Handout?','Sicherung Kernaussagen.'),
-- T10
(10,'sc','Ziel Ausbildungsplan?','Breite Kompetenz & Verantwortung.'),
(10,'tf','Plan Teil des Vertrags. (R/F)','Richtig.'),
(10,'mc','Plan-Inhalte (Mehrfachauswahl)','Inhalte, Zeiträume, Rotation.'),
(10,'gap','Nutzen Rotation?','Überblick / Flexibilität.');

-- Options (pattern similar to earlier full set; only for sc/tf/mc)
-- T1
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=1 AND type='sc' LIMIT 1),'Verzahnung Theorie+Praxis',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='sc' LIMIT 1),'Nur Theorie',0),
((SELECT id FROM questions WHERE unit_id=1 AND type='sc' LIMIT 1),'Nur Praxis',0),
((SELECT id FROM questions WHERE unit_id=1 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1),'Betrieb',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1),'Azubi',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1),'IHK',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1),'Gewerkschaft',0),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1 OFFSET 1),'Schnelle Anwendung',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1 OFFSET 1),'Höhere Behaltensrate',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1 OFFSET 1),'Verantwortungsübernahme',1),
((SELECT id FROM questions WHERE unit_id=1 AND type='mc' LIMIT 1 OFFSET 1),'Abschottung',0);
-- T2
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=2 AND type='sc' LIMIT 1),'90 Minuten, 20 %',1),
((SELECT id FROM questions WHERE unit_id=2 AND type='sc' LIMIT 1),'120 Minuten, 40 %',0),
((SELECT id FROM questions WHERE unit_id=2 AND type='sc' LIMIT 1),'60 Minuten, 25 %',0),
((SELECT id FROM questions WHERE unit_id=2 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=2 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=2 AND type='mc' LIMIT 1),'IHK-Zeugnis',1),
((SELECT id FROM questions WHERE unit_id=2 AND type='mc' LIMIT 1),'Berufsschulzeugnis',1),
((SELECT id FROM questions WHERE unit_id=2 AND type='mc' LIMIT 1),'Betriebszeugnis',1),
((SELECT id FROM questions WHERE unit_id=2 AND type='mc' LIMIT 1),'Abiturzeugnis',0);

-- T3
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=3 AND type='sc' LIMIT 1),'Der Azubi',1),
((SELECT id FROM questions WHERE unit_id=3 AND type='sc' LIMIT 1),'Der Ausbilder',0),
((SELECT id FROM questions WHERE unit_id=3 AND type='sc' LIMIT 1),'Die IHK',0),
((SELECT id FROM questions WHERE unit_id=3 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=3 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=3 AND type='mc' LIMIT 1),'Ausbildung ordnungsgemäß durchführen',1),
((SELECT id FROM questions WHERE unit_id=3 AND type='mc' LIMIT 1),'Für Berufsschule freistellen',1),
((SELECT id FROM questions WHERE unit_id=3 AND type='mc' LIMIT 1),'Fürsorgepflicht beachten',1),
((SELECT id FROM questions WHERE unit_id=3 AND type='mc' LIMIT 1),'Privatfahrten anordnen',0);

-- T4
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=4 AND type='sc' LIMIT 1),'40 Stunden',1),
((SELECT id FROM questions WHERE unit_id=4 AND type='sc' LIMIT 1),'35 Stunden',0),
((SELECT id FROM questions WHERE unit_id=4 AND type='sc' LIMIT 1),'48 Stunden',0),
((SELECT id FROM questions WHERE unit_id=4 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=4 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=4 AND type='mc' LIMIT 1),'Berufsschule',1),
((SELECT id FROM questions WHERE unit_id=4 AND type='mc' LIMIT 1),'Prüfungen',1),
((SELECT id FROM questions WHERE unit_id=4 AND type='mc' LIMIT 1),'Privater Urlaubstag',0),
((SELECT id FROM questions WHERE unit_id=4 AND type='mc' LIMIT 1),'Hobbys',0);

-- T5
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=5 AND type='sc' LIMIT 1),'Arbeitgeber',1),
((SELECT id FROM questions WHERE unit_id=5 AND type='sc' LIMIT 1),'Arbeitnehmer',0),
((SELECT id FROM questions WHERE unit_id=5 AND type='sc' LIMIT 1),'Finanzamt',0),
((SELECT id FROM questions WHERE unit_id=5 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=5 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=5 AND type='mc' LIMIT 1),'Lohnsteuer',1),
((SELECT id FROM questions WHERE unit_id=5 AND type='mc' LIMIT 1),'Rentenversicherung',1),
((SELECT id FROM questions WHERE unit_id=5 AND type='mc' LIMIT 1),'Krankenversicherung',1),
((SELECT id FROM questions WHERE unit_id=5 AND type='mc' LIMIT 1),'Privatmiete',0);

-- T6
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=6 AND type='sc' LIMIT 1),'Schutz vor Diskriminierung',1),
((SELECT id FROM questions WHERE unit_id=6 AND type='sc' LIMIT 1),'Urlaubsanspruchsdauer',0),
((SELECT id FROM questions WHERE unit_id=6 AND type='sc' LIMIT 1),'Mindestlohn berechnen',0),
((SELECT id FROM questions WHERE unit_id=6 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=6 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=6 AND type='mc' LIMIT 1),'ArbZG',1),
((SELECT id FROM questions WHERE unit_id=6 AND type='mc' LIMIT 1),'TzBfG',1),
((SELECT id FROM questions WHERE unit_id=6 AND type='mc' LIMIT 1),'MiLoG',1),
((SELECT id FROM questions WHERE unit_id=6 AND type='mc' LIMIT 1),'StVO',0);

-- T7
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=7 AND type='sc' LIMIT 1),'5 wahlberechtigte',1),
((SELECT id FROM questions WHERE unit_id=7 AND type='sc' LIMIT 1),'3',0),
((SELECT id FROM questions WHERE unit_id=7 AND type='sc' LIMIT 1),'10',0),
((SELECT id FROM questions WHERE unit_id=7 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=7 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=7 AND type='mc' LIMIT 1),'Arbeitgeberverbände',1),
((SELECT id FROM questions WHERE unit_id=7 AND type='mc' LIMIT 1),'Gewerkschaften',1),
((SELECT id FROM questions WHERE unit_id=7 AND type='mc' LIMIT 1),'Betriebsrat',0),
((SELECT id FROM questions WHERE unit_id=7 AND type='mc' LIMIT 1),'Kunden',0);

-- T8
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=8 AND type='sc' LIMIT 1),'2 Jahre',1),
((SELECT id FROM questions WHERE unit_id=8 AND type='sc' LIMIT 1),'4 Jahre',0),
((SELECT id FROM questions WHERE unit_id=8 AND type='sc' LIMIT 1),'1 Jahr',0),
((SELECT id FROM questions WHERE unit_id=8 AND type='tf' LIMIT 1),'Richtig',0),
((SELECT id FROM questions WHERE unit_id=8 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=8 AND type='mc' LIMIT 1),'Interessen vertreten',1),
((SELECT id FROM questions WHERE unit_id=8 AND type='mc' LIMIT 1),'Ausbildungsplätze überwachen',1),
((SELECT id FROM questions WHERE unit_id=8 AND type='mc' LIMIT 1),'Anregungen an BR weitergeben',1),
((SELECT id FROM questions WHERE unit_id=8 AND type='mc' LIMIT 1),'Disziplinarstrafen verhängen',0);

-- T9
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=9 AND type='sc' LIMIT 1),'Inhalte anpassen',1),
((SELECT id FROM questions WHERE unit_id=9 AND type='sc' LIMIT 1),'Zeit sparen',0),
((SELECT id FROM questions WHERE unit_id=9 AND type='sc' LIMIT 1),'Technik testen',0),
((SELECT id FROM questions WHERE unit_id=9 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=9 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=9 AND type='mc' LIMIT 1),'Folien',1),
((SELECT id FROM questions WHERE unit_id=9 AND type='mc' LIMIT 1),'Flipchart',1),
((SELECT id FROM questions WHERE unit_id=9 AND type='mc' LIMIT 1),'Handout',1),
((SELECT id FROM questions WHERE unit_id=9 AND type='mc' LIMIT 1),'Privatchat',0);

-- T10
INSERT INTO options(question_id,label,is_correct) VALUES
((SELECT id FROM questions WHERE unit_id=10 AND type='sc' LIMIT 1),'Breite Kompetenz & Verantwortung',1),
((SELECT id FROM questions WHERE unit_id=10 AND type='sc' LIMIT 1),'Nur Profit',0),
((SELECT id FROM questions WHERE unit_id=10 AND type='sc' LIMIT 1),'Nur Theorie',0),
((SELECT id FROM questions WHERE unit_id=10 AND type='tf' LIMIT 1),'Richtig',1),
((SELECT id FROM questions WHERE unit_id=10 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=10 AND type='mc' LIMIT 1),'Inhalte',1),
((SELECT id FROM questions WHERE unit_id=10 AND type='mc' LIMIT 1),'Zeiträume',1),
((SELECT id FROM questions WHERE unit_id=10 AND type='mc' LIMIT 1),'Rotation',1),
((SELECT id FROM questions WHERE unit_id=10 AND type='mc' LIMIT 1),'Privatadresse Ausbilder',0);
COMMIT;
