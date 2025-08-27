-- ACHTUNG: Dieses Seed-Skript muss auf die Datei server/learn.db angewendet werden!
-- Beispiel: sqlite3 server/learn.db < server/src/seed/002_demo_unit.sql

-- Prüfe, ob die Demo-Unit existiert
INSERT INTO units (topic_id, title, summary) 
SELECT 1, 'Arbeitsplatz einrichten – Grundlagen', 'Grundlagen für einen IT-gestützten Arbeitsplatz.'
WHERE NOT EXISTS (SELECT 1 FROM units WHERE title = 'Arbeitsplatz einrichten – Grundlagen');

INSERT INTO flashcards (unit_id, question, answer, difficulty)
SELECT u.id, 'Was gehört zu einem IT-gestützten Arbeitsplatz?', 'Hardware, Betriebssystem, Office/Tools, Netzwerkzugang, Sicherheit (AV/Updates), Benutzerrechte.', 2
FROM units u WHERE u.title = 'Arbeitsplatz einrichten – Grundlagen';

INSERT INTO flashcards (unit_id, question, answer, difficulty)
SELECT u.id, 'Was ist der Zweck eines Betriebssystems?', 'Verwaltet Hardware-Ressourcen, stellt Dienste für Anwendungen bereit, bietet Benutzeroberfläche.', 2
FROM units u WHERE u.title = 'Arbeitsplatz einrichten – Grundlagen';

INSERT INTO flashcards (unit_id, question, answer, difficulty)
SELECT u.id, 'Nenne zwei Sicherheits-Basics am Arbeitsplatz.', 'Aktuelle Updates/AV; starke Passwörter/Mehrfaktor; gesperrter Bildschirm.', 2
FROM units u WHERE u.title = 'Arbeitsplatz einrichten – Grundlagen';

INSERT INTO flashcards (unit_id, question, answer, difficulty)
SELECT u.id, 'Was ist Treibersoftware?', 'Software, die das Betriebssystem mit Hardware-Komponenten kommunizieren lässt.', 2
FROM units u WHERE u.title = 'Arbeitsplatz einrichten – Grundlagen';

INSERT INTO flashcards (unit_id, question, answer, difficulty)
SELECT u.id, 'Wozu dient Benutzer- und Rechteverwaltung?', 'Least Privilege, Schutz vor Fehlbedienung/Angriffen, Nachvollziehbarkeit.', 2
FROM units u WHERE u.title = 'Arbeitsplatz einrichten – Grundlagen';

INSERT INTO flashcards (unit_id, question, answer, difficulty)
SELECT u.id, 'Was prüfst du bei der Arbeitsplatzabnahme?', 'Funktion, Updates, Netz, Drucker, Datensicherung, Virenschutz, Dokumentation.', 2
FROM units u WHERE u.title = 'Arbeitsplatz einrichten – Grundlagen';
-- Kapitel in LF1
INSERT INTO chapters (learning_field_id, title, position) VALUES (1, 'Arbeitsplatz einrichten – Grundlagen', 1);

-- Topic
INSERT INTO topics (chapter_id, title, position) VALUES (1, 'Hardware/Software-Basics', 1);

-- Unit
INSERT INTO units (topic_id, title, summary, content_html) VALUES (
	1,
	'PC-Arbeitsplatz: Komponenten und Sicherheit',
	'• Zentrale Hardware-Komponenten
• Peripheriegeräte
• Betriebssystem-Grundlagen
• Software-Installation
• Datensicherung
• Ergonomie und Sicherheit
• Virenschutz und Updates',
	'<h2>PC-Arbeitsplatz: Komponenten und Sicherheit</h2><ul><li>Zentrale Hardware-Komponenten</li><li>Peripheriegeräte</li><li>Betriebssystem-Grundlagen</li><li>Software-Installation</li><li>Datensicherung</li><li>Ergonomie und Sicherheit</li><li>Virenschutz und Updates</li></ul>'
);

-- Flashcards
INSERT INTO flashcards (unit_id, question, answer, difficulty) VALUES
	(1, 'Was ist die Hauptfunktion der CPU?', 'Steuerung und Verarbeitung von Befehlen', 1),
	(1, 'Nenne zwei Beispiele für Peripheriegeräte.', 'Drucker, Maus', 1),
	(1, 'Warum sind regelmäßige Updates wichtig?', 'Schließen von Sicherheitslücken', 2),
	(1, 'Was versteht man unter Datensicherung?', 'Kopieren von Daten zur Wiederherstellung bei Verlust', 2),
	(1, 'Nenne ein Beispiel für ergonomische Arbeitsplatzgestaltung.', 'Verstellbarer Stuhl', 1),
	(1, 'Wozu dient ein Virenscanner?', 'Erkennung und Entfernung von Schadsoftware', 2);

-- Quiz (1 Unit, 8 Fragen)
INSERT INTO quizzes (unit_id, scope, title, config_json) VALUES (1, 'unit', 'Demo-Quiz: Arbeitsplatz', '{}');

-- Fragen
INSERT INTO questions (quiz_id, unit_id, type, stem, explanation) VALUES
	(1, 1, 'sc', 'Was ist die Hauptfunktion der CPU?', 'Die CPU steuert und verarbeitet Befehle.'),
	(1, 1, 'mc', 'Welche gehören zu den Peripheriegeräten?', 'Mehrere Antworten möglich.'),
	(1, 1, 'tf', 'Ein Virenscanner schützt vor Schadsoftware.', 'Aussage ist korrekt.'),
	(1, 1, 'sc', 'Was ist ein Beispiel für Datensicherung?', 'Backup auf externer Festplatte.'),
	(1, 1, 'mc', 'Was trägt zur Ergonomie am Arbeitsplatz bei?', 'Mehrere richtige Antworten.'),
	(1, 1, 'tf', 'Regelmäßige Updates sind unwichtig.', 'Das ist falsch.'),
	(1, 1, 'sc', 'Wozu dient das Betriebssystem?', 'Es steuert die Hardware und ermöglicht Programmausführung.'),
	(1, 1, 'mc', 'Was sind Aufgaben eines Betriebssystems?', 'Mehrere richtige Antworten.');

-- Antwortoptionen
-- Q1 (SC)
INSERT INTO options (question_id, label, is_correct) VALUES (1, 'Steuerung und Verarbeitung von Befehlen', 1), (1, 'Stromversorgung', 0), (1, 'Datensicherung', 0);
-- Q2 (MC)
INSERT INTO options (question_id, label, is_correct) VALUES (2, 'Maus', 1), (2, 'CPU', 0), (2, 'Drucker', 1), (2, 'RAM', 0);
-- Q3 (TF)
INSERT INTO options (question_id, label, is_correct) VALUES (3, 'Wahr', 1), (3, 'Falsch', 0);
-- Q4 (SC)
INSERT INTO options (question_id, label, is_correct) VALUES (4, 'Backup auf externer Festplatte', 1), (4, 'Monitor reinigen', 0), (4, 'Software installieren', 0);
-- Q5 (MC)
INSERT INTO options (question_id, label, is_correct) VALUES (5, 'Verstellbarer Stuhl', 1), (5, 'Blendfreier Monitor', 1), (5, 'Alte Tastatur', 0), (5, 'Dunkler Raum', 0);
-- Q6 (TF)
INSERT INTO options (question_id, label, is_correct) VALUES (6, 'Wahr', 0), (6, 'Falsch', 1);
-- Q7 (SC)
INSERT INTO options (question_id, label, is_correct) VALUES (7, 'Steuert Hardware und Programme', 1), (7, 'Erstellt Backups', 0), (7, 'Schützt vor Viren', 0);
-- Q8 (MC)
INSERT INTO options (question_id, label, is_correct) VALUES (8, 'Speicherverwaltung', 1), (8, 'Benutzeroberfläche', 1), (8, 'Papier einlegen', 0), (8, 'Geräte steuern', 1);
