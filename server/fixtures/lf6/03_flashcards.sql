-- LF6 Flashcards (vollständig gemäß Vorgabe)
BEGIN TRANSACTION;
DELETE FROM flashcards WHERE unit_id BETWEEN 6801 AND 6807;
INSERT INTO flashcards(unit_id,question,answer,difficulty) VALUES
-- 6801 Eigene Rolle im Betrieb (8)
(6801,'Was ist die Rolle des Azubis?','Lernender und Mitarbeiter.',1),
(6801,'Welche Pflicht gilt für Berichtshefte?','Regelmäßig und vollständig führen.',1),
(6801,'Was bedeutet Eigenverantwortung?','Aufgaben selbstständig bearbeiten.',1),
(6801,'Warum ist Teamarbeit wichtig?','Effizienz und bessere Ergebnisse.',1),
(6801,'Beispiel für persönliche Entwicklung?','Selbstorganisation verbessern.',1),
(6801,'Beispiel für fachliche Entwicklung?','Neue Programmiersprache lernen.',1),
(6801,'Was bedeutet „Verantwortung übernehmen“?','Für Ergebnisse einstehen.',1),
(6801,'Warum ist Kommunikation wichtig?','Missverständnisse vermeiden.',1),
-- 6802 Ausbildungsbetrieb beschreiben & präsentieren (8)
(6802,'Welche Infos gehören in eine Betriebsbeschreibung?','Geschichte, Struktur, Produkte/Dienstleistungen, Kunden.',1),
(6802,'Was zeigt ein Organigramm?','Hierarchie und Abteilungen.',1),
(6802,'Beispiel für Produkt eines IT-Betriebs?','Softwarelösungen.',1),
(6802,'Beispiel für Dienstleistung eines IT-Betriebs?','IT-Beratung.',1),
(6802,'Warum ist Marktstellung wichtig?','Position im Wettbewerb erkennen.',1),
(6802,'Wer sind Geschäftspartner?','Zulieferer, Kooperationsfirmen.',1),
(6802,'Warum ist Präsentieren wichtig?','Betrieb nach außen darstellen können.',1),
(6802,'Welche Medien nutzt man bei Präsentationen?','Folien, Handouts, Webseiten.',1),
-- 6803 Rechte und Pflichten in der Ausbildung (8)
(6803,'Was sind Rechte des Azubis?','Ausbildung, Vergütung, Urlaub, Zeugnis.',1),
(6803,'Was sind Pflichten des Azubis?','Lernen, Sorgfalt, Schweigepflicht, Berichtsheft.',1),
(6803,'Welche Pflicht gilt gegenüber Berufsschule?','Teilnahme & Mitarbeit.',1),
(6803,'Was garantiert §17 BBiG?','Anspruch auf Vergütung.',2),
(6803,'Was garantiert JArbSchG?','Schutz für Jugendliche.',2),
(6803,'Was ist Schweigepflicht?','Keine Weitergabe von Betriebsgeheimnissen.',1),
(6803,'Was ist Sorgfaltspflicht?','Gewissenhafte Arbeit.',1),
(6803,'Wer stellt Zeugnis aus?','Ausbildungsbetrieb.',1),
-- 6804 Betriebliche Organisation & Prozesse (8)
(6804,'Unterschied Aufbau- vs. Ablauforganisation?','Aufbau = Struktur, Ablauf = Prozesse.',1),
(6804,'Was ist ein Organigramm?','Darstellung der Hierarchie.',1),
(6804,'Was ist ein Prozessdiagramm?','Darstellung von Workflows.',1),
(6804,'Was bedeutet QMS?','Qualitätsmanagement-System.',2),
(6804,'Welche Norm ist für Qualität bekannt?','ISO 9001.',2),
(6804,'Warum gibt es Abteilungen?','Aufgaben spezialisieren.',1),
(6804,'Was bedeutet Schnittstelle?','Übergang zwischen Abteilungen/Prozessen.',1),
(6804,'Ziel eines QMS?','Qualität sichern und verbessern.',1),
-- 6805 Marktpotenzial & Leistungsangebot (8)
(6805,'Was ist Marktpotenzial?','Chancen und Möglichkeiten am Markt.',1),
(6805,'Was ist ein USP?','Alleinstellungsmerkmal.',1),
(6805,'Beispiel für USP?','Besondere IT-Sicherheitslösung.',2),
(6805,'Warum sind Wettbewerber wichtig?','Vergleich für eigene Position.',1),
(6805,'Welche Infos liefert Marktanalyse?','Kundenbedürfnisse, Trends.',1),
(6805,'Beispiel für Vertriebsweg?','Online-Shop.',1),
(6805,'Beispiel für Marketingmaßnahme?','Social-Media-Kampagne.',1),
(6805,'Was ist Ziel einer Marktanalyse?','Strategieplanung.',1),
-- 6806 Zusammenarbeit im Betrieb (8)
(6806,'Wichtige Partner im Betrieb?','Kunden, Kollegen, Vorgesetzte.',1),
(6806,'Was bedeutet Kundenorientierung?','Bedürfnisse des Kunden stehen im Mittelpunkt.',1),
(6806,'Beispiel für Soft Skill?','Kommunikationsfähigkeit.',1),
(6806,'Warum ist Feedback wichtig?','Verbesserungen ermöglichen.',1),
(6806,'Was bedeutet aktives Zuhören?','Konzentriertes, verständnisvolles Zuhören.',1),
(6806,'Was ist Konfliktlösung?','Probleme fair und sachlich klären.',1),
(6806,'Warum Teamarbeit wertvoll?','Gemeinsame Ergebnisse besser.',1),
(6806,'Warum Präsentationen wichtig?','Infos klar vermitteln.',1),
-- 6807 Zukunftsperspektiven & persönliche Entwicklung (8)
(6807,'Beispiel für Karriereweg nach Ausbildung?','IT-Consultant.',1),
(6807,'Beispiel für Weiterbildung?','Fachwirt, Studium, Zertifikat.',1),
(6807,'Beispiel für Spezialisierung?','Datenbankadministrator.',1),
(6807,'Warum ist Selbstreflexion wichtig?','Eigene Stärken erkennen.',1),
(6807,'Wer kann Ausbilder werden?','Fachkräfte mit AEVO.',2),
(6807,'Was bedeutet Projektleitung?','Verantwortung für Planung und Durchführung.',2),
(6807,'Warum Zertifikate wichtig?','Nachweis von Wissen.',1),
(6807,'Welche Rolle spielt lebenslanges Lernen?','Anpassung an neue Technologien.',1);
COMMIT;
