-- Struktur für LF1: Kapitel, Topics (Themen) und Units T1-T10
-- Datei in UTF-8 ohne BOM speichern, damit Umlaute korrekt übernommen werden
-- Annahmen:
--  * Ein Kapitel für LF1 (Kapitel 1)
--  * Jedes Thema = ein Topic und gleichzeitig eine Unit (vereinfachte 1:1 Zuordnung)
--  * topic.position und unit.id Reihenfolge gemäß T1..T10
--  * UTF-8 Umlaute korrekt

PRAGMA foreign_keys=ON;

-- Vorherige LF1-bezogene Daten bereinigen (idempotent)
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id = 1001));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id = 1001);
DELETE FROM chapters WHERE learning_field_id = 1001;

-- Kapitel für LF1
INSERT INTO chapters (id, learning_field_id, title, position) VALUES
(1, 1001, 'LF1: Das Unternehmen und die eigene Rolle im Betrieb', 1);

-- Topics (Themen) für Kapitel 1
INSERT INTO topics (id, chapter_id, title, position) VALUES
(1, 1, 'T1. IT-Ausbildungsberufe & duales System (Überblick)', 1),
(2, 1, 'T2. Gestreckte Abschlussprüfung & Zeugnisse', 2),
(3, 1, 'T3. Rechte & Pflichten im Ausbildungsverhältnis (BBiG) + Ausbildungsvertrag', 3),
(4, 1, 'T4. Jugendarbeitsschutzgesetz (JArbSchG)', 4),
(5, 1, 'T5. Vergütung, Abzüge, Teilzeitausbildung', 5),
(6, 1, 'T6. Arbeitsrecht-Basics', 6),
(7, 1, 'T7. Mitbestimmung: Betriebsrat, Betriebsvereinbarungen, Tarifvertrag & Streik', 7),
(8, 1, 'T8. JAV (Jugend- und Auszubildendenvertretung)', 8),
(9, 1, 'T9. Ausbildungsbetrieb präsentieren', 9),
(10, 1, 'T10. Betriebsnahes Lernen: Ausbildungsplan & Einsatzrotation', 10);

-- Units zu jedem Topic (gleiche IDs wie Topic-ID für einfache Referenz)
INSERT INTO units (id, topic_id, title, summary, content_html) VALUES
(1, 1, 'T1. IT-Ausbildungsberufe & duales System (Überblick)', 'Überblick über IT-Berufe, Lernfelder, duales System, Lernorte und IHK-Rolle.', '<p>Überblick über IT-Berufe, gemeinsamer Kern der Lernfelder 1–6, Lernorte Betrieb & Berufsschule, Rolle der IHK.</p>'),
(2, 2, 'T2. Gestreckte Abschlussprüfung & Zeugnisse', 'Ablauf AP Teil 1 (20 %) und Teil 2/3, sowie Zeugnisse (BBS/IHK/Betrieb).', '<p>Gestreckte Abschlussprüfung: Teil 1 (90 Min ~20%), Teil 2 schriftlich + Projekt/Fachgespräch. Zeugnisse von BBS, IHK, Betrieb.</p>'),
(3, 3, 'T3. Rechte & Pflichten im Ausbildungsverhältnis (BBiG) + Ausbildungsvertrag', 'Gegenseitige Pflichten, Freistellung, Nachweis, Mindestinhalte (§11 BBiG).', '<p>Pflichten: Auszubildende lernen, Betriebsordnung beachten; Ausbildende ausbilden, Freistellen für Schule/Prüfungen. Mindestinhalte gem. §11 BBiG.</p>'),
(4, 4, 'T4. Jugendarbeitsschutzgesetz (JArbSchG)', 'Arbeitszeiten, Pausen, Schule, Urlaub, Freistellung vor Prüfungen.', '<p>Regeln zu Höchstarbeitszeit, Ruhepausen, Berufsschultagen, Urlaubstagen und Freistellung vor Prüfungen nach JArbSchG.</p>'),
(5, 5, 'T5. Vergütung, Abzüge, Teilzeitausbildung', 'Brutto/Netto, Sozialabgaben, Teilzeit nach §8 BBiG.', '<p>Ausbildungsvergütung: Zusammensetzung, Abzüge (Steuern, SV). Teilzeit-Ausbildung beantragbar nach §8 BBiG über die IHK.</p>'),
(6, 6, 'T6. Arbeitsrecht-Basics', 'Wichtige Gesetze: ArbZG, TzBfG, KSchG, AGG, MiLoG, BUrlG, MuSchG/BEEG.', '<p>Überblick zentrale Gesetze: Arbeitszeit, Teilzeit/Befristung, Kündigungsschutz, Gleichbehandlung, Mindestlohn, Urlaub, Mutterschutz/Elternzeit.</p>'),
(7, 7, 'T7. Mitbestimmung: Betriebsrat, Betriebsvereinbarungen, Tarifvertrag & Streik', 'Betriebsrat, Tarifverträge, Streik & Mitbestimmung im Betrieb.', '<p>Rolle des Betriebsrats, Abschluss von Betriebsvereinbarungen, Tarifautonomie, Streik & Aussperrung – Rechte und Grenzen.</p>'),
(8, 8, 'T8. JAV (Jugend- und Auszubildendenvertretung)', 'Wahl, Zuständigkeit, Zusammenarbeit mit BR/DGB.', '<p>JAV: Wahlvoraussetzungen, Aufgaben, Zusammenarbeit mit Betriebsrat und Gewerkschaften.</p>'),
(9, 9, 'T9. Ausbildungsbetrieb präsentieren', 'Präsentationsplanung: Rahmenbedingungen, Recherche, Aufbau.', '<p>Planung einer Präsentation: Zielgruppe, Quellenrecherche, Struktur (Einleitung–Hauptteil–Schluss), Visualisierung.</p>'),
(10, 10, 'T10. Betriebsnahes Lernen: Ausbildungsplan & Einsatzrotation', 'Gliederung, Rotation, wachsende Verantwortung.', '<p>Ausbildungsplan: sachliche/zeitliche Gliederung, Einsatzrotation, progressive Verantwortungsübernahme.</p>');
