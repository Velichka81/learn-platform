
-- Struktur für LF3: Clients in Rechnernetzwerke einbinden
PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
-- Lösche alten LF3-Baum (id=3003)
DELETE FROM units WHERE topic_id IN (SELECT id FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=3003));
DELETE FROM topics WHERE chapter_id IN (SELECT id FROM chapters WHERE learning_field_id=3003);
DELETE FROM chapters WHERE learning_field_id=3003;
DELETE FROM learning_fields WHERE id=3003;

INSERT INTO learning_fields(id,code,title,exam_phase,position)
VALUES (3003,'LF3','Clients in Rechnernetzwerke einbinden','AP1',3);

-- Kapitelstruktur (1 Kapitel pro Thema)
INSERT INTO chapters(id,learning_field_id,title,position) VALUES
 (3301,3003,'1) Einführung in Netzwerke & Unternehmensbeispiel',1),
 (3302,3003,'2) Hauptbestandteile von Computernetzen',2),
 (3303,3003,'3) Computernetze im Überblick',3),
 (3304,3003,'4) Rechenzentren & Serversysteme',4),
 (3305,3003,'5) Clients im Überblick',5),
 (3306,3003,'6) Grundlagen der Datenübertragung',6),
 (3307,3003,'7) Netzwerkmedien & Topologien',7),
 (3308,3003,'8) Zugriffsverfahren & Ethernet',8),
 (3309,3003,'9) Adressierung & Protokolle',9),
 (3310,3003,'10) Sicherheit, Redundanz & Green IT',10);

-- Topics (1 pro Kapitel)
INSERT INTO topics(id,chapter_id,title,position) VALUES
 (3401,3301,'Netzwerküberblick & Komponenten',1),
 (3402,3302,'Bestandteile & Netzgeräte',1),
 (3403,3303,'Netzarten & Architekturen',1),
 (3404,3304,'Rechenzentren & Servertypen',1),
 (3405,3305,'Clienttypen & Geräte',1),
 (3406,3306,'Datenübertragung & Adressierung',1),
 (3407,3307,'Medien & Topologien',1),
 (3408,3308,'Ethernet & Zugriffsverfahren',1),
 (3409,3309,'Protokolle & Adressierung',1),
 (3410,3310,'Sicherheit & Green IT',1);

-- Units (1 pro Topic, Platzhalter)
INSERT INTO units(id,topic_id,title,summary,content_html) VALUES
 (301,3401,'Netzwerküberblick im Ausbildungsbetrieb','Überblick, Komponenten, Aufgaben','<p>Platzhalter</p>'),
 (302,3402,'Hauptbestandteile & Netzgeräte','Definition, Nodes, Geräte, Endgeräte','<p>Platzhalter</p>'),
 (303,3403,'Computernetze im Überblick','Netzarten, Peer-to-Peer, Client-Server','<p>Platzhalter</p>'),
 (304,3404,'Rechenzentren & Serversysteme','Datacenter, Servertypen','<p>Platzhalter</p>'),
 (305,3405,'Clients im Überblick','Clienttypen, Geräte, IoT','<p>Platzhalter</p>'),
 (306,3406,'Grundlagen der Datenübertragung','Datenrate, Übertragungsarten, Adressierung','<p>Platzhalter</p>'),
 (307,3407,'Netzwerkmedien & Topologien','Kabel, Drahtlos, Topologien','<p>Platzhalter</p>'),
 (308,3408,'Zugriffsverfahren & Ethernet','Medienzugriff, Ethernet, Vorteile','<p>Platzhalter</p>'),
 (309,3409,'Adressierung & Protokolle','MAC, IP, Ports, Modelle','<p>Platzhalter</p>'),
 (310,3410,'Sicherheit, Redundanz & Green IT','Firewalls, Backup, Green IT','<p>Platzhalter</p>');
COMMIT;
