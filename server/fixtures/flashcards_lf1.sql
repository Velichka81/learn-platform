-- Flashcards Seeds für LF1 (Units 1-10)
-- Annahme: Units 1..10 existieren und entsprechen den Themen T1..T10
-- Schema: flashcards(id AUTOINCREMENT, unit_id, question, answer, difficulty)
-- Doppelte Fragen vermieden; jede Frage eindeutig formuliert.

BEGIN TRANSACTION;
DELETE FROM flashcards WHERE unit_id BETWEEN 1 AND 10;

-- Unit 1 (Duales System)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(1,'Was bedeutet duales Ausbildungssystem?','Parallel: betriebliche Praxis + schulische Theorie',1),
(1,'Welches Organ überwacht IT-Ausbildungen?','Industrie- und Handelskammer (IHK)',1),
(1,'Warum gibt es Lernfelder in der Berufsschule?','Strukturieren theoretische Inhalte handlungsorientiert',2),
(1,'Welche Lernfelder sind für AP Teil 1 relevant?','Lernfelder 1 bis 6',1),
(1,'Welche Hauptaufgabe hat der Betrieb für dich?','Vermittlung praktischer Fertigkeiten (z.B. Programmierung, Support)',2),
(1,'Welche Hauptaufgabe hat die Berufsschule?','Vermittlung theoretischer Grundlagen (Technik, Prozesse, Wirtschaft)',2),
(1,'Was muss mit dem Ausbildungsvertrag passieren?','Er muss bei der IHK registriert werden',1),
(1,'Nenne ein Beispiel für praktische Tätigkeit in der IT-Ausbildung.','Netzwerkkonfiguration / Software entwickeln / IT-Support',2),
(1,'Wer organisiert die Abschlussprüfungen?','Die IHK organisiert sie',1),
(1,'Welcher Nutzen entsteht durch Verzahnung von Praxis und Theorie?','Direkte Anwendung und Festigung schulischer Inhalte im Betrieb',2);

-- Unit 2 (Gestreckte Abschlussprüfung)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(2,'Seit wann gelten die gestreckten IT-Abschlussprüfungen?','Seit der Neuordnung 2020',1),
(2,'Wie lange dauert AP Teil 1 ungefähr?','Rund 90 Minuten',1),
(2,'Welche Gewichtung hat AP Teil 1 an der Gesamtnote?','20 Prozent',1),
(2,'Auf welchen inhaltlichen Schwerpunkt zielt AP Teil 1 besonders?','Arbeitsplatz einrichten (Lernfelder 1-6)',2),
(2,'Welche Komponenten umfasst AP Teil 2?','Projektarbeit + Dokumentation + Präsentation/Fachgespräch + schriftliche Prüfungen',3),
(2,'Welche drei Zeugnisse erhält ein Azubi am Ende?','IHK-Zeugnis, Berufsschulzeugnis, Betriebszeugnis',1),
(2,'Welches Zeugnis ist rechtlich maßgeblich?','Das IHK-Zeugnis',1),
(2,'Was beschreibt das Betriebszeugnis nach §16 BBiG?','Tätigkeiten und Verhalten im Betrieb',2),
(2,'Wofür steht WISO im Prüfungsteil?','Wirtschafts- und Sozialkunde',1),
(2,'Warum wurde die Prüfung gestreckt?','Kompetenzorientierte Bewertung über zwei Zeitpunkte',2);

-- Unit 3 (Rechte & Pflichten)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(3,'Welches Gesetz bildet den Rahmen für die duale Ausbildung?','Das Berufsbildungsgesetz (BBiG)',1),
(3,'Welche Pflicht hat der Azubi bezüglich Lernbereitschaft?','Er muss aktiv lernen und mitarbeiten',1),
(3,'Wozu dient das Berichtsheft?','Dokumentation von Ausbildungsinhalten und Fortschritt',2),
(3,'Welche Pflicht hat der Betrieb hinsichtlich Lernmitteln?','Er muss erforderliche Arbeits- und Lernmittel bereitstellen',2),
(3,'Wofür muss der Ausbildende freistellen?','Für Berufsschule und Prüfungen',1),
(3,'Welche Zeitspanne ist für die Probezeit zulässig?','Ein bis vier Monate',1),
(3,'Welche Inhalte müssen laut §11 BBiG im Vertrag stehen?','Ziele, Dauer, Probezeit, Vergütung, Arbeitszeit, Urlaub, Kündigung',3),
(3,'Warum ist Verschwiegenheit wichtig?','Schutz von Betriebs- und Geschäftsgeheimnissen',2),
(3,'Wer registriert den Ausbildungsvertrag?','Die IHK',1),
(3,'Was muss der Betrieb am Ende aushändigen?','Ein qualifiziertes Zeugnis',1);

-- Unit 4 (Jugendarbeitsschutz)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(4,'Wen schützt das Jugendarbeitsschutzgesetz?','Jugendliche Auszubildende unter 18 Jahren',1),
(4,'Wie hoch ist die reguläre tägliche Höchstarbeitszeit?','8 Stunden pro Tag',1),
(4,'Welche Wochenarbeitszeit ist maximal vorgesehen?','40 Stunden pro Woche',1),
(4,'Welcher Arbeitszeitraum ist grundsätzlich erlaubt?','Zwischen 6 und 20 Uhr',1),
(4,'Ab welcher Dauer ist eine Pause von mindestens 30 Minuten Pflicht?','Ab mehr als 4,5 Stunden Arbeitszeit',2),
(4,'Wann sind mindestens 60 Minuten Pause nötig?','Ab mehr als 6 Stunden Arbeitszeit',2),
(4,'Wie viele Urlaubstage mindestens bei 17-Jährigen?','Mindestens 25 (altersabhängig steigend bei Jüngeren)',2),
(4,'Welcher Tag ist vor einer schriftlichen Abschlussprüfung frei?','Der vorhergehende Tag',1),
(4,'Welche Untersuchung ist vor Beginn vorgeschrieben?','Erstuntersuchung (ärztlich)',1),
(4,'Warum existieren Sonderregeln für Jugendliche?','Zum Schutz von Gesundheit und Entwicklung',2);

-- Unit 5 (Vergütung & Teilzeit)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(5,'Wie entwickelt sich die Ausbildungsvergütung?','Sie steigt mit jedem Ausbildungsjahr',1),
(5,'Was bedeutet Bruttovergütung?','Betrag vor Steuern und Sozialabgaben',1),
(5,'Was kennzeichnet den Nettobetrag?','Auszahlungsbetrag nach Abzügen',1),
(5,'Wer führt die Sozialversicherungsbeiträge ab?','Der Arbeitgeber',1),
(5,'Welche Versicherungen deckt die Sozialversicherung ab?','Kranken-, Pflege-, Renten-, Arbeitslosenversicherung',2),
(5,'Was regelt §8 BBiG?','Möglichkeit der Teilzeitausbildung bei berechtigtem Interesse',2),
(5,'Wann kann Teilzeit beantragt werden?','Bei familiären oder gesundheitlichen Gründen',2),
(5,'Wer genehmigt eine Teilzeitausbildung?','Die IHK nach Antrag',1),
(5,'Bleibt das Ausbildungsziel bei Teilzeit gleich?','Ja, unverändert',1),
(5,'Was kann sich durch Teilzeit verlängern?','Die Gesamtdauer der Ausbildung',2);

-- Unit 6 (Arbeitsrecht Basics)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(6,'Was regelt das Arbeitszeitgesetz?','Arbeitszeiten, Pausen und Ruhezeiten',1),
(6,'Wogegen schützt das AGG?','Gegen Diskriminierung',1),
(6,'Was sichert das Entgeltfortzahlungsgesetz?','Lohnfortzahlung im Krankheitsfall',2),
(6,'Was legt das Bundesurlaubsgesetz fest?','Mindesturlaub',1),
(6,'Wozu dient das TzBfG?','Regelt Teilzeit und Befristung',2),
(6,'Was schützt das Kündigungsschutzgesetz?','Vor sozial ungerechtfertigten Kündigungen',2),
(6,'Was schreibt das MiLoG vor?','Gesetzlichen Mindestlohn',1),
(6,'Was bedeutet Günstigkeitsprinzip?','Günstigere Regel aus mehreren gilt',2),
(6,'Welches Gesetz schützt Schwangere?','Mutterschutzgesetz (MuSchG)',1),
(6,'Was regelt das BEEG?','Elterngeld und Elternzeit',2);

-- Unit 7 (Mitbestimmung & Tarif)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(7,'Ab wie vielen Mitarbeitern ist ein Betriebsrat möglich?','Ab 5 ständig wahlberechtigten',1),
(7,'Wie lang ist eine Amtszeit des Betriebsrats?','Vier Jahre',1),
(7,'Nenne ein Mitbestimmungsfeld des BR.','Z.B. Einstellungen, Kündigungen oder Arbeitszeit',2),
(7,'Wer schließt Tarifverträge ab?','Gewerkschaften und Arbeitgeberverbände',1),
(7,'Was regelt ein Tarifvertrag?','Arbeitsbedingungen wie Lohn, Urlaub, Arbeitszeit',2),
(7,'Was bedeutet Friedenspflicht?','Keine Streiks während gültiger Tarifverträge',2),
(7,'Wer darf zum Streik aufrufen?','Nur die Gewerkschaft',1),
(7,'Was ist eine Aussperrung?','Reaktion des Arbeitgebers im Arbeitskampf',2),
(7,'Welcher Vorteil hat Tarifbindung?','Planbare und oft bessere Bedingungen',2),
(7,'Was fördert Mitbestimmung grundsätzlich?','Beteiligung und soziale Gerechtigkeit',2);

-- Unit 8 (JAV)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(8,'Was bedeutet JAV?','Jugend- und Auszubildendenvertretung',1),
(8,'Wer ist wahlberechtigt für die JAV?','Azubis unter 18 und Beschäftigte bis 25',1),
(8,'Wie viele Wahlberechtigte braucht man mindestens?','Mindestens fünf',1),
(8,'Wie lange dauert die Amtszeit der JAV?','Zwei Jahre',1),
(8,'Mit welchem Gremium arbeitet die JAV eng zusammen?','Mit dem Betriebsrat',1),
(8,'Nenne eine typische JAV-Aufgabe.','Überwachung BBiG/JArbSchG/BetrVG oder Verbesserungsvorschläge',2),
(8,'Was kann die JAV bei BR-Beschlüssen tun?','Sie kann sie eine Woche aussetzen lassen',2),
(8,'Warum gibt es eine JAV?','Spezielle Vertretung jugendlicher Interessen',2),
(8,'Welches Gesetz bildet die Basis für BR/JAV?','Das Betriebsverfassungsgesetz (BetrVG)',2),
(8,'Wie profitieren Azubis von der JAV?','Durch Feedback und Schutz ihrer Belange',2);

-- Unit 9 (Betrieb präsentieren)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(9,'Was ist der erste Schritt vor einer Präsentation?','Zielgruppe definieren',1),
(9,'Welche Rahmenbedingungen sollten geklärt werden?','Zeit, Raum, Technik, Medien',2),
(9,'Warum ist Zielgruppenanalyse wichtig?','Inhalt und Ton passgenau ausrichten',2),
(9,'Wie lautet die Grundstruktur einer Präsentation?','Einstieg – Hauptteil – Schluss',1),
(9,'Nenne geeignete Quellen für Betriebsinfos.','Website, interne Unterlagen, Interviews',2),
(9,'Warum Medien gezielt einsetzen?','Zur Unterstützung und Visualisierung der Aussagen',2),
(9,'Was verbessert Verständlichkeit stark?','Klare Sprache und Storytelling',2),
(9,'Wozu dient ein Handout?','Nachhaltige Sicherung der Kernaussagen',2),
(9,'Was macht einen guten Einstieg aus?','Aufmerksamkeit wecken, z.B. Frage oder Beispiel',2),
(9,'Was gehört an das Ende?','Zusammenfassung und ggf. Call-to-Action',2);

-- Unit 10 (Ausbildungsplan & Rotation)
INSERT INTO flashcards(unit_id, question, answer, difficulty) VALUES
(10,'Worauf basiert der betriebliche Ausbildungsplan?','Auf der Ausbildungsordnung',1),
(10,'Warum werden Abteilungen rotiert?','Für ganzheitlichen Überblick und Vernetzung',2),
(10,'Nenne typische IT-Stationen der Rotation.','Support, Entwicklung, Administration',2),
(10,'Was steigt mit der Ausbildungsdauer?','Die Eigenverantwortung',1),
(10,'Welches Ziel steht gegen Ende?','Selbstständige Projektarbeit',1),
(10,'Wer überwacht die Umsetzung des Plans?','Die IHK',1),
(10,'Was dokumentiert den Lernfortschritt zusätzlich?','Berichtsheft und Feedbackgespräche',2),
(10,'Warum kann Plananpassung sinnvoll sein?','Bei Stärken, Schwächen oder Veränderungen',2),
(10,'Welche Wirkung hat transparente Planung?','Schafft Vertrauen und Professionalität',2),
(10,'Welcher Vorteil entsteht durch Rotation für den Azubi?','Breites Prozessverständnis und Flexibilität',3);

COMMIT;
