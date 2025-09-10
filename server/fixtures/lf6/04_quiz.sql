PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE unit_id BETWEEN 6801 AND 6807);
DELETE FROM questions WHERE unit_id BETWEEN 6801 AND 6807;

-- LF6 Quiz (je Unit: SC, TF, MC; mind. 4 Optionen bei SC/MC; deterministische Referenzen)
INSERT INTO questions(unit_id,type,stem,explanation) VALUES
-- 6801: Eigene Rolle im Betrieb
(6801,'sc','Was ist die Rolle des Azubis?','Azubis sind Lernende und Mitarbeitende: Sie lernen planmäßig und arbeiten verantwortungsvoll mit; sie sind weder Chef noch Kunde.'),
(6801,'tf','Azubis übernehmen keine Verantwortung.','Falsch: Sie übernehmen alters- und ausbildungsangemessene Verantwortung unter Anleitung.'),
(6801,'mc','Welche Aufgaben hat der Azubi?','Korrekt: Lernen, Berichtsheft, Teamarbeit. Freizeitplanung gehört nicht zur Ausbildung.'),
-- 6802: Ausbildungsbetrieb beschreiben & präsentieren
(6802,'sc','Was zeigt ein Organigramm?','Es zeigt die Aufbauorganisation: Hierarchie, Bereiche und Zuständigkeiten – nicht Umsatz, Produkte oder Konkurrenz.'),
(6802,'tf','Geschäftspartner können Zulieferer sein.','Wahr: Geschäftspartner können u. a. Kunden, Zulieferer oder Kooperationspartner sein.'),
(6802,'mc','Was gehört zur Betriebsbeschreibung?','Typisch: Geschichte, Struktur, Produkte. Eine Urlaubsliste ist keine Betriebsbeschreibung.'),
-- 6803: Rechte und Pflichten in der Ausbildung
(6803,'sc','Welches Recht garantiert §17 BBiG?','§17 BBiG regelt die Vergütung des Auszubildenden.'),
(6803,'tf','Berichtsheft führen ist Pflicht.','Wahr: Das ordnungsgemäße Führen/Vorlegen des Ausbildungsnachweises ist vorgeschrieben.'),
(6803,'mc','Rechte des Azubis?','Rechte: Qualifizierte Ausbildung, Zeugnis, Vergütung. Schweigepflicht ist eine Pflicht, kein Recht.'),
-- 6804: Betriebliche Organisation & Prozesse
(6804,'sc','Was bedeutet Aufbauorganisation?','Struktur und Hierarchie eines Betriebs (Wer macht was/wo?). Nicht zu verwechseln mit Ablauforganisation.'),
(6804,'tf','ISO 9001 ist ein Standard für Qualitätsmanagement.','Wahr: ISO 9001 legt Anforderungen an QM-Systeme fest.'),
(6804,'mc','Welche Tools nutzt man für Organisation?','Organigramm, Prozessdiagramm, QMS sind typische Werkzeuge; die Browser-Historie nicht.'),
-- 6805: Marktpotenzial & Leistungsangebot
(6805,'sc','Was bedeutet USP?','Alleinstellungsmerkmal: Der einzigartige Nutzen, der ein Angebot vom Wettbewerb abhebt.'),
(6805,'tf','Marktanalyse zeigt Kundenbedürfnisse.','Wahr: Sie untersucht u. a. Bedürfnisse, Zielgruppen und Wettbewerber.'),
(6805,'mc','Was gehört zur Marktanalyse?','Kunden, Wettbewerber, Produkte sind relevant; Kantinenessen nicht.'),
-- 6806: Zusammenarbeit im Betrieb
(6806,'sc','Was bedeutet Kundenorientierung?','Ausrichtung auf Kundenbedürfnisse und ‑zufriedenheit statt interne Bequemlichkeit.'),
(6806,'tf','Feedback hilft, die Zusammenarbeit zu verbessern.','Wahr: Es schafft Klarheit, fördert Lernen und verbessert Prozesse/Beziehungen.'),
(6806,'mc','Beispiele für Soft Skills?','Korrekt: Kommunikation, Konfliktlösung, Teamarbeit. Tabellenkalkulation ist ein Hard Skill.'),
-- 6807: Zukunftsperspektiven & persönliche Entwicklung
(6807,'sc','Was ist AEVO?','Ausbildereignungsverordnung: regelt die Eignung/Qualifikation von Ausbilder:innen.'),
(6807,'tf','Zertifikate sind unnötig für die Karriere.','Falsch: Zertifikate können Kenntnisse belegen und Chancen am Arbeitsmarkt erhöhen.'),
(6807,'mc','Welche Weiterbildungsmöglichkeiten gibt es?','Fachwirt, Studium, Zertifikate zählen; Urlaubsreisen sind keine Weiterbildung.');

-- Optionen
INSERT INTO options(question_id,label,is_correct) VALUES
-- 6801
((SELECT id FROM questions WHERE unit_id=6801 AND type='sc' LIMIT 1),'Chef des Betriebs',0),
((SELECT id FROM questions WHERE unit_id=6801 AND type='sc' LIMIT 1),'Lernender & Mitarbeiter',1),
((SELECT id FROM questions WHERE unit_id=6801 AND type='sc' LIMIT 1),'Nur Praktikant',0),
((SELECT id FROM questions WHERE unit_id=6801 AND type='sc' LIMIT 1),'Kunde',0),
((SELECT id FROM questions WHERE unit_id=6801 AND type='tf' LIMIT 1),'Wahr',0),
((SELECT id FROM questions WHERE unit_id=6801 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=6801 AND type='mc' LIMIT 1),'Lernen',1),
((SELECT id FROM questions WHERE unit_id=6801 AND type='mc' LIMIT 1),'Berichtsheft',1),
((SELECT id FROM questions WHERE unit_id=6801 AND type='mc' LIMIT 1),'Teamarbeit',1),
((SELECT id FROM questions WHERE unit_id=6801 AND type='mc' LIMIT 1),'Freizeitplanung',0),
-- 6802
((SELECT id FROM questions WHERE unit_id=6802 AND type='sc' LIMIT 1),'Umsatz',0),
((SELECT id FROM questions WHERE unit_id=6802 AND type='sc' LIMIT 1),'Hierarchie & Abteilungen',1),
((SELECT id FROM questions WHERE unit_id=6802 AND type='sc' LIMIT 1),'Produkte',0),
((SELECT id FROM questions WHERE unit_id=6802 AND type='sc' LIMIT 1),'Konkurrenz',0),
((SELECT id FROM questions WHERE unit_id=6802 AND type='tf' LIMIT 1),'Wahr',1),
((SELECT id FROM questions WHERE unit_id=6802 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=6802 AND type='mc' LIMIT 1),'Geschichte',1),
((SELECT id FROM questions WHERE unit_id=6802 AND type='mc' LIMIT 1),'Struktur',1),
((SELECT id FROM questions WHERE unit_id=6802 AND type='mc' LIMIT 1),'Produkte',1),
((SELECT id FROM questions WHERE unit_id=6802 AND type='mc' LIMIT 1),'Urlaubsliste',0),
-- 6803
((SELECT id FROM questions WHERE unit_id=6803 AND type='sc' LIMIT 1),'Urlaub',0),
((SELECT id FROM questions WHERE unit_id=6803 AND type='sc' LIMIT 1),'Vergütung',1),
((SELECT id FROM questions WHERE unit_id=6803 AND type='sc' LIMIT 1),'Zeugnis',0),
((SELECT id FROM questions WHERE unit_id=6803 AND type='sc' LIMIT 1),'Kündigung',0),
((SELECT id FROM questions WHERE unit_id=6803 AND type='tf' LIMIT 1),'Wahr',1),
((SELECT id FROM questions WHERE unit_id=6803 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=6803 AND type='mc' LIMIT 1),'Ausbildung',1),
((SELECT id FROM questions WHERE unit_id=6803 AND type='mc' LIMIT 1),'Zeugnis',1),
((SELECT id FROM questions WHERE unit_id=6803 AND type='mc' LIMIT 1),'Schweigepflicht',0),
((SELECT id FROM questions WHERE unit_id=6803 AND type='mc' LIMIT 1),'Vergütung',1),
-- 6804
((SELECT id FROM questions WHERE unit_id=6804 AND type='sc' LIMIT 1),'Struktur & Hierarchie',1),
((SELECT id FROM questions WHERE unit_id=6804 AND type='sc' LIMIT 1),'Arbeitsprozesse',0),
((SELECT id FROM questions WHERE unit_id=6804 AND type='sc' LIMIT 1),'Marketing',0),
((SELECT id FROM questions WHERE unit_id=6804 AND type='sc' LIMIT 1),'Weiterbildung',0),
((SELECT id FROM questions WHERE unit_id=6804 AND type='tf' LIMIT 1),'Wahr',1),
((SELECT id FROM questions WHERE unit_id=6804 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=6804 AND type='mc' LIMIT 1),'Organigramm',1),
((SELECT id FROM questions WHERE unit_id=6804 AND type='mc' LIMIT 1),'Prozessdiagramm',1),
((SELECT id FROM questions WHERE unit_id=6804 AND type='mc' LIMIT 1),'QMS',1),
((SELECT id FROM questions WHERE unit_id=6804 AND type='mc' LIMIT 1),'Browser-Historie',0),
-- 6805
((SELECT id FROM questions WHERE unit_id=6805 AND type='sc' LIMIT 1),'Urlaubs-Spar-Plan',0),
((SELECT id FROM questions WHERE unit_id=6805 AND type='sc' LIMIT 1),'Alleinstellungsmerkmal',1),
((SELECT id FROM questions WHERE unit_id=6805 AND type='sc' LIMIT 1),'Unternehmens-Service-Pool',0),
((SELECT id FROM questions WHERE unit_id=6805 AND type='sc' LIMIT 1),'Unbekannter Standardprozess',0),
((SELECT id FROM questions WHERE unit_id=6805 AND type='tf' LIMIT 1),'Wahr',1),
((SELECT id FROM questions WHERE unit_id=6805 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=6805 AND type='mc' LIMIT 1),'Kunden',1),
((SELECT id FROM questions WHERE unit_id=6805 AND type='mc' LIMIT 1),'Wettbewerber',1),
((SELECT id FROM questions WHERE unit_id=6805 AND type='mc' LIMIT 1),'Produkte',1),
((SELECT id FROM questions WHERE unit_id=6805 AND type='mc' LIMIT 1),'Kantinenessen',0),
-- 6806
((SELECT id FROM questions WHERE unit_id=6806 AND type='sc' LIMIT 1),'Mitarbeiter im Fokus',0),
((SELECT id FROM questions WHERE unit_id=6806 AND type='sc' LIMIT 1),'Bedürfnisse des Kunden stehen im Mittelpunkt',1),
((SELECT id FROM questions WHERE unit_id=6806 AND type='sc' LIMIT 1),'Chefentscheidungen',0),
((SELECT id FROM questions WHERE unit_id=6806 AND type='sc' LIMIT 1),'Lieferantenkontakte',0),
((SELECT id FROM questions WHERE unit_id=6806 AND type='tf' LIMIT 1),'Wahr',1),
((SELECT id FROM questions WHERE unit_id=6806 AND type='tf' LIMIT 1),'Falsch',0),
((SELECT id FROM questions WHERE unit_id=6806 AND type='mc' LIMIT 1),'Kommunikation',1),
((SELECT id FROM questions WHERE unit_id=6806 AND type='mc' LIMIT 1),'Konfliktlösung',1),
((SELECT id FROM questions WHERE unit_id=6806 AND type='mc' LIMIT 1),'Teamarbeit',1),
((SELECT id FROM questions WHERE unit_id=6806 AND type='mc' LIMIT 1),'Tabellenkalkulation',0),
-- 6807
((SELECT id FROM questions WHERE unit_id=6807 AND type='sc' LIMIT 1),'Abschlussprüfung',0),
((SELECT id FROM questions WHERE unit_id=6807 AND type='sc' LIMIT 1),'Ausbildereignungsverordnung',1),
((SELECT id FROM questions WHERE unit_id=6807 AND type='sc' LIMIT 1),'IT-Zertifikat',0),
((SELECT id FROM questions WHERE unit_id=6807 AND type='sc' LIMIT 1),'Softwarelizenz',0),
((SELECT id FROM questions WHERE unit_id=6807 AND type='tf' LIMIT 1),'Wahr',0),
((SELECT id FROM questions WHERE unit_id=6807 AND type='tf' LIMIT 1),'Falsch',1),
((SELECT id FROM questions WHERE unit_id=6807 AND type='mc' LIMIT 1),'Fachwirt',1),
((SELECT id FROM questions WHERE unit_id=6807 AND type='mc' LIMIT 1),'Studium',1),
((SELECT id FROM questions WHERE unit_id=6807 AND type='mc' LIMIT 1),'Zertifikate',1),
((SELECT id FROM questions WHERE unit_id=6807 AND type='mc' LIMIT 1),'Urlaubsreisen',0);

COMMIT;
