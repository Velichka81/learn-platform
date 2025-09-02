
-- Struktur für LF3: Clients in Rechnernetzwerke einbinden
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=3003));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=3003);
DELETE FROM chapters WHERE learning_field_id=3003;
DELETE FROM learning_fields WHERE id=3003;

INSERT INTO learning_fields(id,code,title,exam_phase,position) VALUES (3003,'LF3','Clients in Rechnernetzwerke einbinden','AP1',3);
INSERT INTO chapters(id,learning_field_id,title,position) VALUES (3300,3003,'LF3: Clients in Rechnernetzwerke einbinden',1);

INSERT INTO topics(id,chapter_id,title,position) VALUES
 (3601,3300,'T1. Einführung & Unternehmensbeispiel',1),
 (3602,3300,'T2. Hauptbestandteile von Computernetzen',2),
 (3603,3300,'T3. Computernetze im Überblick',3),
 (3604,3300,'T4. Rechenzentren & Serversysteme',4),
 (3605,3300,'T5. Clients im Überblick',5),
 (3606,3300,'T6. Grundlagen der Datenübertragung',6),
 (3607,3300,'T7. Netzwerkmedien & Topologien',7),
 (3608,3300,'T8. Zugriffsverfahren & Ethernet',8),
 (3609,3300,'T9. Adressierung & Protokolle',9),
 (3610,3300,'T10. Sicherheit, Redundanz & Green IT',10);

INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (3601,3601,'T1. Einführung & Unternehmensbeispiel','Überblick & Kontext','<p>(Platzhalter)</p>'),
 (3602,3602,'T2. Hauptbestandteile von Computernetzen','Geräte & Komponenten','<p>(Platzhalter)</p>'),
 (3603,3603,'T3. Computernetze im Überblick','Netzarten & Modelle','<p>(Platzhalter)</p>'),
 (3604,3604,'T4. Rechenzentren & Serversysteme','Servertypen & Aufgaben','<p>(Platzhalter)</p>'),
 (3605,3605,'T5. Clients im Überblick','Clienttypen & Nutzung','<p>(Platzhalter)</p>'),
 (3606,3606,'T6. Grundlagen der Datenübertragung','Übertragungsarten & Adressen','<p>(Platzhalter)</p>'),
 (3607,3607,'T7. Netzwerkmedien & Topologien','Medien & Topologien','<p>(Platzhalter)</p>'),
 (3608,3608,'T8. Zugriffsverfahren & Ethernet','Ethernet & Zugriff','<p>(Platzhalter)</p>'),
 (3609,3609,'T9. Adressierung & Protokolle','Protokolle & Adressierung','<p>(Platzhalter)</p>'),
 (3610,3610,'T10. Sicherheit, Redundanz & Green IT','Sicherheit & Nachhaltigkeit','<p>(Platzhalter)</p>');
COMMIT;
