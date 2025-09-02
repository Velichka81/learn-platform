PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE unit_id BETWEEN 4801 AND 4809);
DELETE FROM questions WHERE unit_id BETWEEN 4801 AND 4809;

-- LF4 Quiz Fragen
-- 4801 Einführung in die Informationssicherheit
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4801,'sc','Was bedeutet Informationssicherheit?','Schutz von Daten, Systemen und Prozessen.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Nur Virenschutz',0),(last_insert_rowid(),'Schutz von Daten, Systemen und Prozessen',1),(last_insert_rowid(),'Schnellere Computer',0),(last_insert_rowid(),'Bessere Grafikkarten',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4801,'tf','Jeder Arbeitsplatz kann ein Risiko für das gesamte Unternehmen darstellen.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4801,'mc','Welche Verbünde gehören zu den Zielen von Netzwerken?','Kommunikations-, Daten- und Ressourcenverbund.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Kommunikationsverbund',1),(last_insert_rowid(),'Datenverbund',1),(last_insert_rowid(),'Ressourcenverbund',1),(last_insert_rowid(),'Küchenverbund',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4801,'sc','Wer trägt die Gesamtverantwortung für Informationssicherheit im Betrieb?','Geschäftsführung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Azubi',0),(last_insert_rowid(),'IT-Support',0),(last_insert_rowid(),'Geschäftsführung',1),(last_insert_rowid(),'Hausmeister',0);

-- 4802 Gesetze, Standards und Aufsichtsbehörden
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4802,'sc','Was regelt die DSGVO?','Datenschutz personenbezogener Daten.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Steuerrecht',0),(last_insert_rowid(),'Datenschutz personenbezogener Daten',1),(last_insert_rowid(),'Arbeitszeit',0),(last_insert_rowid(),'Mietrecht',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4802,'tf','Das IT-Sicherheitsgesetz gilt nur für Privatpersonen.','Falsch.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',0),(last_insert_rowid(),'Falsch',1);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4802,'mc','Welche Standards / Vorgaben betreffen IT-Sicherheit?','ISO 27001, BSI-Standards, BSIG.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'ISO 27001',1),(last_insert_rowid(),'BSI-Standards',1),(last_insert_rowid(),'DIN 5008',0),(last_insert_rowid(),'BSIG',1);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4802,'sc','Wer ist in Deutschland oberster Datenschützer?','BfDI.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'IT-Systemhaus',0),(last_insert_rowid(),'BfDI – Bundesdatenschutzbeauftragter',1),(last_insert_rowid(),'Bürgermeister',0),(last_insert_rowid(),'Handelskammer',0);

-- 4803 IT-Grundschutz & Schutzziele
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4803,'sc','Was bedeutet Vertraulichkeit?','Zugriff nur für Berechtigte.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Daten immer öffentlich',0),(last_insert_rowid(),'Zugriff nur für Berechtigte',1),(last_insert_rowid(),'Daten dürfen nie gelöscht werden',0),(last_insert_rowid(),'Zugriff ohne Passwort',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4803,'tf','Das CIA-Prinzip steht für Confidentiality, Integrity, Availability.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4803,'mc','Welche ergänzenden Schutzziele gibt es?','Authentizität, Verbindlichkeit.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Authentizität',1),(last_insert_rowid(),'Verbindlichkeit',1),(last_insert_rowid(),'Geschwindigkeit',0),(last_insert_rowid(),'Rentabilität',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4803,'sc','Was beschreibt Integrität?','Daten dürfen nicht unbemerkt verändert werden.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Daten dürfen nicht unbemerkt verändert werden',1),(last_insert_rowid(),'Daten werden regelmäßig gesichert',0),(last_insert_rowid(),'Daten sind jederzeit verfügbar',0),(last_insert_rowid(),'Daten sind verschlüsselt',0);

-- 4804 Gefährdungen & Schadensszenarien
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4804,'sc','Was ist Social Engineering?','Manipulation von Menschen zur Datengewinnung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Neue Programmiersprache',0),(last_insert_rowid(),'Manipulation von Menschen zur Datengewinnung',1),(last_insert_rowid(),'Netzwerkstandard',0),(last_insert_rowid(),'Verschlüsselungsverfahren',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4804,'tf','Das BSI definiert 47 elementare Gefährdungen.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4804,'mc','Welche Schadenskategorien gibt es?','Niedrig, Normal, Hoch, Sehr hoch.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Niedrig',1),(last_insert_rowid(),'Normal',1),(last_insert_rowid(),'Hoch',1),(last_insert_rowid(),'Sehr hoch',1);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4804,'sc','Was ist ein indirekter Schaden?','Image- oder Vertrauensverlust.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Imageverlust',1),(last_insert_rowid(),'Rechnungsfehler',0),(last_insert_rowid(),'Kurzschluss',0),(last_insert_rowid(),'Datenbankabsturz',0);

-- 4805 Der Faktor Mensch
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4805,'sc','Was ist Phishing?','Betrugsversuch über gefälschte E-Mails.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Virenschutz',0),(last_insert_rowid(),'Betrugsversuch über gefälschte E-Mails',1),(last_insert_rowid(),'Firewallsystem',0),(last_insert_rowid(),'Backupprozess',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4805,'tf','Der Mensch gilt als größtes Risiko in der Informationssicherheit.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4805,'mc','Beispiele für menschliche Fehler?','Offener Bildschirm, USB-Stick liegen lassen, Phishing-Mail öffnen.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Offener Bildschirm',1),(last_insert_rowid(),'USB-Stick liegen lassen',1),(last_insert_rowid(),'Phishing-Mail öffnen',1),(last_insert_rowid(),'RAID-System konfigurieren',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4805,'sc','Was sind Awareness-Programme?','Schulungen / Sensibilisierung für Sicherheit.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Schulungen/Sensibilisierung für Sicherheit',1),(last_insert_rowid(),'Programme zum Drucken',0),(last_insert_rowid(),'Virensoftware',0),(last_insert_rowid(),'Neue Hardware',0);

-- 4806 Technisch-organisatorische Maßnahmen (TOMs)
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4806,'sc','Was ist Zugangskontrolle?','Zutritt ins Gebäude / Serverraum.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Zugriff auf Dateien',0),(last_insert_rowid(),'Zutritt ins Gebäude/Serverraum',1),(last_insert_rowid(),'Passwortkontrolle',0),(last_insert_rowid(),'Backup-System',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4806,'tf','Übertragungskontrolle kann durch Verschlüsselung erfolgen.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4806,'mc','Beispiele für TOMs?','Benutzer-, Datenträger-, Übertragungskontrolle.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Benutzerkontrolle',1),(last_insert_rowid(),'Datenträgerkontrolle',1),(last_insert_rowid(),'Übertragungskontrolle',1),(last_insert_rowid(),'Kantinenkontrolle',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4806,'sc','Was ist Wiederherstellbarkeit?','Daten nach Ausfall wiederherstellen können.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Immer neue Daten erzeugen',0),(last_insert_rowid(),'Daten nach Ausfall wiederherstellen können',1),(last_insert_rowid(),'Nur Firewalls installieren',0),(last_insert_rowid(),'Mitarbeiter überwachen',0);

-- 4807 Phasen des Sicherheitsprozesses nach BSI
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4807,'sc','Was ist erster Schritt im Sicherheitsprozess?','Sicherheitsleitlinie erstellen.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Risikoanalyse',0),(last_insert_rowid(),'Sicherheitsleitlinie erstellen',1),(last_insert_rowid(),'Marketinganalyse',0),(last_insert_rowid(),'Backups einspielen',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4807,'tf','Der BSI-Prozess basiert auf dem PDCA-Zyklus.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4807,'mc','Welche Schritte gehören dazu?','Strukturanalyse, Schutzbedarfsfeststellung, Risikoanalyse.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Strukturanalyse',1),(last_insert_rowid(),'Schutzbedarfsfeststellung',1),(last_insert_rowid(),'Risikoanalyse',1),(last_insert_rowid(),'Marketingstrategie',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4807,'sc','Warum wiederholt sich der Prozess regelmäßig?','Kontinuierliche Verbesserung der Sicherheit.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Aus Langeweile',0),(last_insert_rowid(),'Weil Sicherheit kontinuierlich verbessert werden muss',1),(last_insert_rowid(),'Damit Prüfer Arbeit haben',0),(last_insert_rowid(),'Damit Azubis beschäftigt sind',0);

-- 4808 Beispielunternehmen RECPLAST GmbH
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4808,'sc','Wofür dient das RECPLAST-Beispiel?','Praxisbeispiel für BSI-Methodik.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Marketing',0),(last_insert_rowid(),'Praxisbeispiel für BSI-Methodik',1),(last_insert_rowid(),'Netzwerkaufbau',0),(last_insert_rowid(),'Personalplanung',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4808,'tf','RECPLAST bewertet Schutzbedarf mit "niedrig, normal, hoch, sehr hoch".','Falsch (nur normal, hoch, sehr hoch).');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',0),(last_insert_rowid(),'Falsch',1);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4808,'mc','Welche Schritte macht RECPLAST?','Strukturanalyse, Sicherheitsleitlinie, Schutzbedarfsfeststellung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Strukturanalyse',1),(last_insert_rowid(),'Sicherheitsleitlinie',1),(last_insert_rowid(),'Schutzbedarfsfeststellung',1),(last_insert_rowid(),'Gehaltsabrechnung',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4808,'sc','Warum ist das Beispiel hilfreich?','Zeigt praktische Anwendung der Methodik.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Nur für Prüfungen',0),(last_insert_rowid(),'Zeigt, wie Methodik praktisch angewendet wird',1),(last_insert_rowid(),'Marketingzwecke',0),(last_insert_rowid(),'Nur Theorie',0);

-- 4809 Schutzbedarfsfeststellung im eigenen Betrieb
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4809,'sc','Was ist Ziel einer Schutzbedarfsfeststellung?','Prioritäten für Sicherheitsmaßnahmen festlegen.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Urlaubsplanung',0),(last_insert_rowid(),'Prioritäten für Sicherheitsmaßnahmen festlegen',1),(last_insert_rowid(),'Mitarbeiterkontrolle',0),(last_insert_rowid(),'Marketing',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4809,'tf','Ein defekter Drucker hat meist "sehr hohen" Schutzbedarf.','Falsch.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',0),(last_insert_rowid(),'Falsch',1);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4809,'mc','Beispiele für Schutzobjekte?','Kundendaten, Finanzsysteme, Arbeitsplatz-PC.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Kundendaten',1),(last_insert_rowid(),'Finanzsysteme',1),(last_insert_rowid(),'Arbeitsplatz-PC',1),(last_insert_rowid(),'Kantinenplan',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (4809,'sc','Was ist ein Schutzobjekt mit sehr hohem Schutzbedarf?','Finanzbuchhaltung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Finanzbuchhaltung',1),(last_insert_rowid(),'Drucker',0),(last_insert_rowid(),'Kantine',0),(last_insert_rowid(),'Pausenraum',0);

COMMIT;
