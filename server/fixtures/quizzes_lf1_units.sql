-- Quiz Questions & Options Seeds für LF1 Units 1-10
-- Annahme: Units 1..10 vorhanden. Wir erzeugen 5–8 Fragen je Unit.
-- Schema:
-- questions(id AUTOINCREMENT, quiz_id NULL, unit_id, type(mc|sc|tf|gap|match), stem, explanation)
-- options(id AUTOINCREMENT, question_id, label, is_correct)
-- Für offene/gap-Fragen (type=gap) werden keine options angelegt; Antwortprüfung später textbasiert erweiterbar.

BEGIN TRANSACTION;
-- Löschen bestehender Fragen der Units 1..10
DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE unit_id BETWEEN 1 AND 10);
DELETE FROM questions WHERE unit_id BETWEEN 1 AND 10;

/* ==================== Unit 1 ==================== */
-- 7 Fragen (SC/MC/TF + 1 offene gap)
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(1,'sc','Welche Aussage beschreibt das duale System am präzisesten?','Dual = systematische Verzahnung von Praxis im Betrieb und Theorie in der Berufsschule.'),
(1,'mc','Welche Elemente fallen in die Verantwortung der IHK? (Mehrfachauswahl)','IHK registriert Verträge, berät und organisiert Prüfungen.'),
(1,'tf','Lernfelder strukturieren vor allem praktische Betriebsaufgaben. (Richtig/Falsch)','Falsch: Sie strukturieren vor allem die schulisch-theoretischen Inhalte.'),
(1,'sc','Welcher Vorteil entsteht unmittelbar aus der Parallelität von Theorie und Praxis?','Direkte Anwendung des Gelernten fördert nachhaltiges Verständnis.'),
(1,'mc','Welche Beispiele zählen zur betrieblichen Praxis eines IT-Azubis? (Mehrfachauswahl)','Aufgaben wie Support, Netzwerk einrichten oder Software entwickeln sind typische Praxis.'),
(1,'gap','Kurz: Nenne zwei zentrale Lernorte der IT-Ausbildung.','Gesucht: Betrieb und Berufsschule.'),
(1,'tf','Die IHK führt die Abschlussprüfungen durch. (Richtig/Falsch)','Richtig: Sie ist Prüfungsorgan.');
-- Options Unit 1
INSERT INTO options(question_id,label,is_correct) VALUES
/* Q1 sc */( (SELECT id FROM questions WHERE unit_id=1 AND type='sc' ORDER BY id LIMIT 1),'Praxis und Theorie getrennt nacheinander',0),
( (SELECT id FROM questions WHERE unit_id=1 AND type='sc' ORDER BY id LIMIT 1),'Verzahnung von Praxis und Theorie',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='sc' ORDER BY id LIMIT 1),'Nur schulische Ausbildung mit Praxisprojekt',0),
/* Q2 mc */( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1),'Verträge registrieren',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1),'Individuelle Vergütung festsetzen',0),
( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1),'Prüfungen organisieren',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1),'Beratung von Betrieben und Azubis',1),
/* Q3 tf */( (SELECT id FROM questions WHERE unit_id=1 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=1 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* Q4 sc */( (SELECT id FROM questions WHERE unit_id=1 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Schnellere Probezeitverkürzung',0),
( (SELECT id FROM questions WHERE unit_id=1 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Direkte Anwendung und Festigung',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Mehr Urlaubstage pro Jahr',0),
/* Q5 mc */( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'IT-Support leisten',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Netzwerk einrichten',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Steuerbescheide erstellen',0),
( (SELECT id FROM questions WHERE unit_id=1 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Software entwickeln',1),
/* Q7 tf (second tf) */( (SELECT id FROM questions WHERE unit_id=1 AND type='tf' ORDER BY id LIMIT 1 OFFSET 1),'Richtig',1),
( (SELECT id FROM questions WHERE unit_id=1 AND type='tf' ORDER BY id LIMIT 1 OFFSET 1),'Falsch',0);

/* ==================== Unit 2 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(2,'sc','Wie hoch ist die Gewichtung von AP Teil 1?','Er fließt mit 20% in die Endnote ein.'),
(2,'tf','AP Teil 1 findet typischerweise im letzten Ausbildungsmonat statt. (R/F)','Falsch: ungefähr nach 18 Monaten.'),
(2,'mc','Welche Komponenten gehören zu AP Teil 2? (Mehrfachauswahl)','Projektarbeit mit Doku, Fachgespräch/Präsentation und schriftliche Prüfungen.'),
(2,'sc','Welchen Schwerpunkt hat AP Teil 1?','Arbeitsplatz einrichten (Lernfelder 1–6).'),
(2,'gap','Offen: Nenne ein Zeugnis neben dem IHK-Zeugnis.','Berufsschulzeugnis oder Betriebszeugnis.'),
(2,'mc','Wofür steht WISO im Kontext der Prüfung? (Mehrfachauswahl)','Wirtschafts- und Sozialkunde ist Teil der schriftlichen Prüfungen.'),
(2,'tf','Das Betriebszeugnis enthält die Gesamtnote der IHK-Prüfung. (R/F)','Falsch: Es beschreibt Tätigkeiten und Verhalten.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U2 Q1 sc */( (SELECT id FROM questions WHERE unit_id=2 AND type='sc' ORDER BY id LIMIT 1),'10%',0),
( (SELECT id FROM questions WHERE unit_id=2 AND type='sc' ORDER BY id LIMIT 1),'20%',1),
( (SELECT id FROM questions WHERE unit_id=2 AND type='sc' ORDER BY id LIMIT 1),'35%',0),
/* U2 Q2 tf */( (SELECT id FROM questions WHERE unit_id=2 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=2 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U2 Q3 mc */( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1),'Projektarbeit + Dokumentation',1),
( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1),'Präsentation & Fachgespräch',1),
( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1),'Schriftliche Prüfungen (Fach & WISO)',1),
( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1),'Zwischenprüfung wiederholen',0),
/* U2 Q4 sc */( (SELECT id FROM questions WHERE unit_id=2 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Datenbanken administrieren',0),
( (SELECT id FROM questions WHERE unit_id=2 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Arbeitsplatz einrichten',1),
( (SELECT id FROM questions WHERE unit_id=2 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Netzwerksegmentierung optimieren',0),
/* U2 Q6 mc */( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Wirtschafts- & Sozialkunde',1),
( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Reine Programmierpraxis',0),
( (SELECT id FROM questions WHERE unit_id=2 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Sozialkompetenz-Assessment',0),
/* U2 Q7 tf */( (SELECT id FROM questions WHERE unit_id=2 AND type='tf' ORDER BY id LIMIT 1 OFFSET 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=2 AND type='tf' ORDER BY id LIMIT 1 OFFSET 1),'Falsch',1);

/* ==================== Unit 3 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(3,'mc','Welche Pflichten treffen Azubis? (Mehrfachauswahl)','Lernpflicht, Berichtsheft, Ordnung, Verschwiegenheit.'),
(3,'sc','Wer muss Lernmittel stellen?','Der ausbildende Betrieb, um Ausbildungsziel zu erreichen.'),
(3,'tf','Probezeit kann 8 Monate dauern. (R/F)','Falsch: 1–4 Monate erlaubt.'),
(3,'mc','Welche Inhalte muss der Ausbildungsvertrag enthalten? (Mehrfachauswahl)','§11 BBiG: Ziel, Dauer, Probezeit, Vergütung, Arbeitszeit, Urlaub, Kündigung.'),
(3,'gap','Offen: Nenne ein Motiv für Verschwiegenheit.','Schutz von Geschäfts- bzw. Betriebsgeheimnissen.'),
(3,'sc','Wer registriert den Ausbildungsvertrag?','Die IHK registriert und überwacht.'),
(3,'tf','Der Betrieb muss für Prüfungen freistellen. (R/F)','Richtig: Freistellungspflicht besteht.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U3 Q1 mc */( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1),'Lernpflicht',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1),'Berichtsheft führen',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1),'Steuererklärungen für Kollegen abgeben',0),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1),'Betriebsordnungen beachten',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1),'Geheimhaltung',1),
/* U3 Q2 sc */( (SELECT id FROM questions WHERE unit_id=3 AND type='sc' ORDER BY id LIMIT 1),'Der Azubi selbst',0),
( (SELECT id FROM questions WHERE unit_id=3 AND type='sc' ORDER BY id LIMIT 1),'Der Betrieb',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='sc' ORDER BY id LIMIT 1),'Die Berufsschule',0),
/* U3 Q3 tf */( (SELECT id FROM questions WHERE unit_id=3 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=3 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U3 Q4 mc */( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Vergütung',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Arbeitszeit',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Urlaub',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Probezeit',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Private Hobbys',0),
/* U3 Q6 sc */( (SELECT id FROM questions WHERE unit_id=3 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Die IHK',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Die Suva',0),
( (SELECT id FROM questions WHERE unit_id=3 AND type='sc' ORDER BY id LIMIT 1 OFFSET 1),'Das Arbeitsamt',0),
/* U3 Q7 tf */( (SELECT id FROM questions WHERE unit_id=3 AND type='tf' ORDER BY id LIMIT 1 OFFSET 1),'Richtig',1),
( (SELECT id FROM questions WHERE unit_id=3 AND type='tf' ORDER BY id LIMIT 1 OFFSET 1),'Falsch',0);

/* ==================== Unit 4 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(4,'sc','Maximale tägliche Arbeitszeit für Jugendliche?','8 Stunden nach JArbSchG.'),
(4,'tf','Nachtarbeit (23–5 Uhr) ist für Jugendliche generell erlaubt. (R/F)','Falsch: grundsätzlich verboten, Ausnahmen branchenspezifisch.'),
(4,'mc','Was schreibt das JArbSchG bzgl. Pausen vor? (Mehrfachauswahl)','Mind. 30 Min >4.5h, mind. 60 Min >6h.'),
(4,'sc','Wozu dienen Pflichtuntersuchungen?','Überprüfung Gesundheitszustand / Eignung.'),
(4,'gap','Offen: Freier Tag vor welcher Prüfung?','Vor der schriftlichen Abschlussprüfung.'),
(4,'tf','Jugendliche haben weniger Schutz bei Urlaub als Erwachsene. (R/F)','Falsch: teils mehr Urlaub je nach Alter.'),
(4,'mc','Warum besondere Schutzregeln für Jugendliche? (Mehrfachauswahl)','Gesundheit & Entwicklung sichern, Überforderung verhindern.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U4 Q1 sc */( (SELECT id FROM questions WHERE unit_id=4 AND type='sc' ORDER BY id LIMIT 1),'8 Stunden',1),
( (SELECT id FROM questions WHERE unit_id=4 AND type='sc' ORDER BY id LIMIT 1),'10 Stunden',0),
( (SELECT id FROM questions WHERE unit_id=4 AND type='sc' ORDER BY id LIMIT 1),'6 Stunden',0),
/* U4 Q2 tf */( (SELECT id FROM questions WHERE unit_id=4 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=4 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U4 Q3 mc */( (SELECT id FROM questions WHERE unit_id=4 AND type='mc' ORDER BY id LIMIT 1),'30 Min ab >4.5h',1),
( (SELECT id FROM questions WHERE unit_id=4 AND type='mc' ORDER BY id LIMIT 1),'60 Min ab >6h',1),
( (SELECT id FROM questions WHERE unit_id=4 AND type='mc' ORDER BY id LIMIT 1),'15 Min ab >3h',0),
/* U4 Q4 sc */( (SELECT id FROM questions WHERE unit_id=4 AND type='sc' ORDER BY id LIMIT 1),'Kontrolle Gesundheit/Eignung',1),
( (SELECT id FROM questions WHERE unit_id=4 AND type='sc' ORDER BY id LIMIT 1),'Lohnerhöhung festlegen',0),
( (SELECT id FROM questions WHERE unit_id=4 AND type='sc' ORDER BY id LIMIT 1),'Urlaubsanspruch berechnen',0),
/* U4 Q6 tf */( (SELECT id FROM questions WHERE unit_id=4 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=4 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U4 Q7 mc */( (SELECT id FROM questions WHERE unit_id=4 AND type='mc' ORDER BY id LIMIT 1),'Gesundheitsschutz',1),
( (SELECT id FROM questions WHERE unit_id=4 AND type='mc' ORDER BY id LIMIT 1),'Förderung künstlicher Überstunden',0),
( (SELECT id FROM questions WHERE unit_id=4 AND type='mc' ORDER BY id LIMIT 1),'Verhinderung von Überforderung',1);

/* ==================== Unit 5 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(5,'sc','Was passiert mit der Vergütung pro Ausbildungsjahr?','Sie erhöht sich normalerweise stufenweise.'),
(5,'tf','Brutto = Netto. (R/F)','Falsch: Abzüge reduzieren den Betrag.'),
(5,'mc','Welche Bestandteile zählen zur Sozialversicherung? (Mehrfachauswahl)','Kranken-, Pflege-, Renten-, Arbeitslosenversicherung.'),
(5,'sc','Wofür steht Teilzeitausbildung nach §8 BBiG?','Reduzierte Arbeitszeit bei berechtigtem Interesse.'),
(5,'gap','Offen: Wer führt die Beiträge ab?','Der Arbeitgeber.'),
(5,'tf','Teilzeit ändert das Ausbildungsziel. (R/F)','Falsch: Ziel bleibt identisch.'),
(5,'mc','Welche Gründe rechtfertigen Teilzeitausbildung? (Mehrfachauswahl)','Familie, Pflege, gesundheitliche Gründe.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U5 Q1 sc */( (SELECT id FROM questions WHERE unit_id=5 AND type='sc' ORDER BY id LIMIT 1),'Sie sinkt jährlich',0),
( (SELECT id FROM questions WHERE unit_id=5 AND type='sc' ORDER BY id LIMIT 1),'Sie steigt stufenweise',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='sc' ORDER BY id LIMIT 1),'Sie bleibt unverändert',0),
/* U5 Q2 tf */( (SELECT id FROM questions WHERE unit_id=5 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=5 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U5 Q3 mc */( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Krankenversicherung',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Pflegeversicherung',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Hausratversicherung',0),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Rentenversicherung',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Arbeitslosenversicherung',1),
/* U5 Q4 sc */( (SELECT id FROM questions WHERE unit_id=5 AND type='sc' ORDER BY id LIMIT 1),'Teilzeit bei beliebigem Wunsch',0),
( (SELECT id FROM questions WHERE unit_id=5 AND type='sc' ORDER BY id LIMIT 1),'Reduzierte Zeit bei berechtigtem Interesse',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='sc' ORDER BY id LIMIT 1),'Nur für Arbeitgeber',0),
/* U5 Q6 tf */( (SELECT id FROM questions WHERE unit_id=5 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=5 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U5 Q7 mc */( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Familienpflichten',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Gesundheitliche Gründe',1),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Reines Interesse am kürzeren Tag',0),
( (SELECT id FROM questions WHERE unit_id=5 AND type='mc' ORDER BY id LIMIT 1),'Pflege Angehöriger',1);

/* ==================== Unit 6 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(6,'mc','Welche Gesetze schützen Arbeitnehmer? (Mehrfachauswahl)','ArbZG, AGG, EntgFG, BUrlG u.a. sichern verschiedene Aspekte.'),
(6,'sc','Wozu dient das ArbZG primär?','Regelt Höchstarbeitszeiten und Pausen.'),
(6,'tf','Das AGG verbietet Diskriminierung. (R/F)','Richtig: Schützt vor Benachteiligung.'),
(6,'mc','Welche Elemente umfasst Sozialschutz bei Krankheit/Mutterschaft? (Mehrfachauswahl)','EntgFG für Lohnfortzahlung, MuSchG für Schutz werdender Mütter.'),
(6,'gap','Offen: Was bewirkt das Günstigkeitsprinzip?','Günstigere Regelung setzt sich durch.'),
(6,'sc','Was regelt das MiLoG?','Gesetzlichen Mindestlohn.'),
(6,'tf','BEEG beinhaltet Elternzeit-Regelungen. (R/F)','Richtig: Elternzeit & Elterngeld.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U6 Q1 mc */( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1),'ArbZG',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1),'AGG',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1),'Privates Vereinsrecht',0),
( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1),'BUrlG',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1),'EntgFG',1),
/* U6 Q2 sc */( (SELECT id FROM questions WHERE unit_id=6 AND type='sc' ORDER BY id LIMIT 1),'Regelt Mindestlohn',0),
( (SELECT id FROM questions WHERE unit_id=6 AND type='sc' ORDER BY id LIMIT 1),'Regelt Arbeits- und Pausenzeiten',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='sc' ORDER BY id LIMIT 1),'Regelt Elternzeit',0),
/* U6 Q3 tf */( (SELECT id FROM questions WHERE unit_id=6 AND type='tf' ORDER BY id LIMIT 1),'Richtig',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='tf' ORDER BY id LIMIT 1),'Falsch',0),
/* U6 Q4 mc */( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'EntgFG',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'MuSchG',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'AGB',0),
/* U6 Q6 sc */( (SELECT id FROM questions WHERE unit_id=6 AND type='sc' ORDER BY id LIMIT 1),'Mind. Urlaub',0),
( (SELECT id FROM questions WHERE unit_id=6 AND type='sc' ORDER BY id LIMIT 1),'Mindestlohn',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='sc' ORDER BY id LIMIT 1),'Mutterschutz',0),
/* U6 Q7 tf */( (SELECT id FROM questions WHERE unit_id=6 AND type='tf' ORDER BY id LIMIT 1),'Richtig',1),
( (SELECT id FROM questions WHERE unit_id=6 AND type='tf' ORDER BY id LIMIT 1),'Falsch',0);

/* ==================== Unit 7 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(7,'sc','Ab welcher Anzahl wahlberechtigter Mitarbeiter ist ein BR möglich?','Ab 5 – gesetzliche Mindestvoraussetzung.'),
(7,'tf','Nur Arbeitgeber dürfen Streiks ausrufen. (R/F)','Falsch: nur Gewerkschaften. '),
(7,'mc','Welche Themen fallen unter Mitbestimmung des BR? (Mehrfachauswahl)','Einstellungen, Kündigungen, Arbeitszeitgestaltung.'),
(7,'sc','Was bedeutet Friedenspflicht?','Keine Arbeitskämpfe während Tariflaufzeit.'),
(7,'gap','Offen: Wer schließt Tarifverträge ab?','Arbeitgeberverbände und Gewerkschaften.'),
(7,'mc','Vorteile von Tarifbindung? (Mehrfachauswahl)','Planbare Konditionen, oft bessere Vergütung & Schutz.'),
(7,'tf','Aussperrung ist eine Maßnahme von Arbeitnehmern. (R/F)','Falsch: Maßnahme des Arbeitgebers.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U7 Q1 sc */( (SELECT id FROM questions WHERE unit_id=7 AND type='sc' ORDER BY id LIMIT 1),'Ab 3',0),
( (SELECT id FROM questions WHERE unit_id=7 AND type='sc' ORDER BY id LIMIT 1),'Ab 5',1),
( (SELECT id FROM questions WHERE unit_id=7 AND type='sc' ORDER BY id LIMIT 1),'Ab 10',0),
/* U7 Q2 tf */( (SELECT id FROM questions WHERE unit_id=7 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=7 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U7 Q3 mc */( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1),'Einstellungen',1),
( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1),'Kündigungen',1),
( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1),'Privaturlaube genehmigen',0),
( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1),'Arbeitszeitmodelle',1),
/* U7 Q4 sc */( (SELECT id FROM questions WHERE unit_id=7 AND type='sc' ORDER BY id LIMIT 1),'Eskalationsprozedur',0),
( (SELECT id FROM questions WHERE unit_id=7 AND type='sc' ORDER BY id LIMIT 1),'Streitverzicht während Tarifvertrag',1),
( (SELECT id FROM questions WHERE unit_id=7 AND type='sc' ORDER BY id LIMIT 1),'Zwang zur Lohnerhöhung',0),
/* U7 Q6 mc */( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Planbare Bedingungen',1),
( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Willkürliche Kürzungen',0),
( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Bessere Vergütung',1),
( (SELECT id FROM questions WHERE unit_id=7 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Rechtsunsicherheit',0),
/* U7 Q7 tf */( (SELECT id FROM questions WHERE unit_id=7 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=7 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1);

/* ==================== Unit 8 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(8,'sc','Mindestanzahl Wahlberechtigte für eine JAV?','Mindestens fünf sind nötig.'),
(8,'mc','Aufgaben der JAV? (Mehrfachauswahl)','Überwachung von BBiG/JArbSchG/BetrVG; Verbesserungen anregen.'),
(8,'tf','JAV kann BR-Beschlüsse nie verzögern. (R/F)','Falsch: sie kann eine Woche Aufschub bewirken.'),
(8,'sc','Wer darf JAV wählen?','Azubis <18 und Beschäftigte bis 25 Jahre.'),
(8,'gap','Offen: Mit wem arbeitet die JAV eng zusammen?','Mit dem Betriebsrat (BR).'),
(8,'mc','Wie profitieren Azubis von der JAV? (Mehrfachauswahl)','Interessenvertretung & Feedbackkanal für Ausbildungsqualität.'),
(8,'tf','Die Amtszeit der JAV beträgt vier Jahre. (R/F)','Falsch: zwei Jahre.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U8 Q1 sc */( (SELECT id FROM questions WHERE unit_id=8 AND type='sc' ORDER BY id LIMIT 1),'3',0),
( (SELECT id FROM questions WHERE unit_id=8 AND type='sc' ORDER BY id LIMIT 1),'5',1),
( (SELECT id FROM questions WHERE unit_id=8 AND type='sc' ORDER BY id LIMIT 1),'7',0),
/* U8 Q2 mc */( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1),'Überwachung einschlägiger Gesetze',1),
( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1),'Lohnabrechnung erstellen',0),
( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1),'Verbesserungsvorschläge',1),
( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1),'Teilnahme an BR-Sitzungen',1),
/* U8 Q3 tf */( (SELECT id FROM questions WHERE unit_id=8 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=8 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U8 Q4 sc */( (SELECT id FROM questions WHERE unit_id=8 AND type='sc' ORDER BY id LIMIT 1),'Nur Vollzeit-Azubis',0),
( (SELECT id FROM questions WHERE unit_id=8 AND type='sc' ORDER BY id LIMIT 1),'Azubis <18 und Beschäftigte bis 25',1),
( (SELECT id FROM questions WHERE unit_id=8 AND type='sc' ORDER BY id LIMIT 1),'Nur Mitarbeitende über 25',0),
/* U8 Q6 mc */( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Interessenvertretung',1),
( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Schlechterer Informationsfluss',0),
( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Feedbackkanal',1),
( (SELECT id FROM questions WHERE unit_id=8 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Rechtlose Stellung',0),
/* U8 Q7 tf */( (SELECT id FROM questions WHERE unit_id=8 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=8 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1);

/* ==================== Unit 9 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(9,'sc','Erster Schritt vor Ausarbeitung einer Präsentation?','Analyse/Definition der Zielgruppe.'),
(9,'mc','Was sollte vorab geklärt werden? (Mehrfachauswahl)','Zeit, Raum, Technik/Medien, Zielgruppe.'),
(9,'tf','Storytelling kann die Wirkung einer Präsentation verbessern. (R/F)','Richtig: erhöht Aufmerksamkeit & Merkfähigkeit.'),
(9,'mc','Was gehört zur Grundstruktur? (Mehrfachauswahl)','Einstieg, Hauptteil, Schluss.'),
(9,'gap','Offen: Nenne eine Quelle für Betriebsinformationen.','Website / interne Unterlagen / Interviews.'),
(9,'sc','Wozu dient ein Handout?','Nachhaltige Sicherung der Kerninhalte.'),
(9,'tf','Ein überladener Foliensatz fördert die Verständlichkeit. (R/F)','Falsch: er lenkt ab.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U9 Q1 sc */( (SELECT id FROM questions WHERE unit_id=9 AND type='sc' ORDER BY id LIMIT 1),'Zielgruppe definieren',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='sc' ORDER BY id LIMIT 1),'Handout layouten',0),
( (SELECT id FROM questions WHERE unit_id=9 AND type='sc' ORDER BY id LIMIT 1),'PowerPoint öffnen',0),
/* U9 Q2 mc */( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1),'Zeit',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1),'Raum',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1),'Private Hobbys',0),
( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1),'Technik & Medien',1),
/* U9 Q3 tf */( (SELECT id FROM questions WHERE unit_id=9 AND type='tf' ORDER BY id LIMIT 1),'Richtig',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='tf' ORDER BY id LIMIT 1),'Falsch',0),
/* U9 Q4 mc */( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Einstieg',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Hauptteil',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Schluss',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Unstrukturierter Block',0),
/* U9 Q6 sc */( (SELECT id FROM questions WHERE unit_id=9 AND type='sc' ORDER BY id LIMIT 1),'Nur Deko',0),
( (SELECT id FROM questions WHERE unit_id=9 AND type='sc' ORDER BY id LIMIT 1),'Sicherung der Kerninhalte',1),
( (SELECT id FROM questions WHERE unit_id=9 AND type='sc' ORDER BY id LIMIT 1),'Verkürzung der Redezeit',0),
/* U9 Q7 tf */( (SELECT id FROM questions WHERE unit_id=9 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=9 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1);

/* ==================== Unit 10 ==================== */
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
(10,'sc','Worauf basiert der betriebliche Ausbildungsplan?','Auf der staatlichen Ausbildungsordnung.'),
(10,'mc','Warum Abteilungsrotation? (Mehrfachauswahl)','Fördert Überblick, Vernetzung und Kompetenzbreite.'),
(10,'tf','Eigenverantwortung sinkt zum Ende der Ausbildung. (R/F)','Falsch: sie steigt.'),
(10,'mc','Wodurch dokumentiert sich Fortschritt? (Mehrfachauswahl)','Berichtsheft, Feedbackgespräche.'),
(10,'gap','Offen: Nenne ein Ziel am Ende der Ausbildung.','Selbstständige Projektarbeit.'),
(10,'sc','Wer überwacht die Umsetzung des Plans?','Die IHK.'),
(10,'tf','Rotation erhöht Flexibilität des Azubis. (R/F)','Richtig: vielfältige Einblicke steigern Anpassungsfähigkeit.');
INSERT INTO options(question_id,label,is_correct) VALUES
/* U10 Q1 sc */( (SELECT id FROM questions WHERE unit_id=10 AND type='sc' ORDER BY id LIMIT 1),'Auf persönlichen Vorlieben',0),
( (SELECT id FROM questions WHERE unit_id=10 AND type='sc' ORDER BY id LIMIT 1),'Auf der Ausbildungsordnung',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='sc' ORDER BY id LIMIT 1),'Auf spontanem Tagesgeschäft',0),
/* U10 Q2 mc */( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1),'Überblick fördern',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1),'Monotone Spezialisierung sichern',0),
( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1),'Vernetzung verbessern',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1),'Kompetenzbreite erweitern',1),
/* U10 Q3 tf */( (SELECT id FROM questions WHERE unit_id=10 AND type='tf' ORDER BY id LIMIT 1),'Richtig',0),
( (SELECT id FROM questions WHERE unit_id=10 AND type='tf' ORDER BY id LIMIT 1),'Falsch',1),
/* U10 Q4 mc */( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Berichtsheft',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Feedbackgespräche',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='mc' ORDER BY id LIMIT 1 OFFSET 1),'Spontane Zurufe',0),
/* U10 Q6 sc */( (SELECT id FROM questions WHERE unit_id=10 AND type='sc' ORDER BY id LIMIT 1),'Die IHK',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='sc' ORDER BY id LIMIT 1),'Der Lieferant',0),
( (SELECT id FROM questions WHERE unit_id=10 AND type='sc' ORDER BY id LIMIT 1),'Externe Auditoren standardmäßig',0),
/* U10 Q7 tf */( (SELECT id FROM questions WHERE unit_id=10 AND type='tf' ORDER BY id LIMIT 1),'Richtig',1),
( (SELECT id FROM questions WHERE unit_id=10 AND type='tf' ORDER BY id LIMIT 1),'Falsch',0);

COMMIT;
