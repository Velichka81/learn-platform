-- LF3 Structure Seed: Clients in Rechnernetzwerke einbinden
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
-- Clean previous LF3 (id=3003) if exists
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=3003));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=3003);
DELETE FROM chapters WHERE learning_field_id=3003;
DELETE FROM learning_fields WHERE id=3003;

INSERT INTO learning_fields(id,code,title,exam_phase,position)
VALUES (3003,'LF3','Clients in Rechnernetzwerke einbinden','AP1',3);

INSERT INTO chapters(id,learning_field_id,title,position)
VALUES (3101,3003,'LF3: Clients in Rechnernetzwerke einbinden',1);

-- Topics (1..10) jeweils eigene Unit
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (3301,3101,'1) Einführung in Netzwerke & Unternehmensbeispiel',1),
 (3302,3101,'2) Hauptbestandteile von Computernetzen',2),
 (3303,3101,'3) Computernetze im Überblick',3),
 (3304,3101,'4) Rechenzentren & Serversysteme',4),
 (3305,3101,'5) Clients im Überblick',5),
 (3306,3101,'6) Grundlagen der Datenübertragung',6),
 (3307,3101,'7) Netzwerkmedien & Topologien',7),
 (3308,3101,'8) Zugriffsverfahren & Ethernet',8),
 (3309,3101,'9) Adressierung & Protokolle',9),
 (3310,3101,'10) Sicherheit, Redundanz & Green IT',10);

INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (301,3301,'1) Einführung in Netzwerke & Unternehmensbeispiel','Netzwerküberblick & Komponenten','<p>(Platzhalter)</p>'),
 (302,3302,'2) Hauptbestandteile von Computernetzen','Geräte & Rollen','<p>(Platzhalter)</p>'),
 (303,3303,'3) Computernetze im Überblick','Netztypen & Architekturen','<p>(Platzhalter)</p>'),
 (304,3304,'4) Rechenzentren & Serversysteme','RZ-Modelle & Serverarten','<p>(Platzhalter)</p>'),
 (305,3305,'5) Clients im Überblick','Client-Typen & Geräte','<p>(Platzhalter)</p>'),
 (306,3306,'6) Grundlagen der Datenübertragung','Übertragungsarten & Adressierung','<p>(Platzhalter)</p>'),
 (307,3307,'7) Netzwerkmedien & Topologien','Medien & Strukturen','<p>(Platzhalter)</p>'),
 (308,3308,'8) Zugriffsverfahren & Ethernet','CSMA/CD & Ethernet Evolution','<p>(Platzhalter)</p>'),
 (309,3309,'9) Adressierung & Protokolle','MAC, IP, OSI, TCP/IP','<p>(Platzhalter)</p>'),
 (310,3310,'10) Sicherheit, Redundanz & Green IT','Schutz & Effizienz','<p>(Platzhalter)</p>');
COMMIT;
PRAGMA foreign_keys=ON;
