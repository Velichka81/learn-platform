PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE unit_id BETWEEN 301 AND 310);
DELETE FROM questions WHERE unit_id BETWEEN 301 AND 310;

-- LF3 Quiz: Original + eigene, thematisch passende Ergänzungen, keine Dopplungen
-- 301 Einführung in Netzwerke & Unternehmensbeispiel
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (301,'sc','Welches Ziel hat ein Firmennetzwerk?','Kommunikation, Daten- & Ressourcenverbund.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Nur Internetzugang',0),(last_insert_rowid(),'Nur Druckdienste',0),(last_insert_rowid(),'Kommunikation, Daten- & Ressourcenverbund',1),(last_insert_rowid(),'Nur Spielezugang',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (301,'tf','Ein Router verbindet verschiedene Netzwerke.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (301,'mc','Welche Geräte sind typische Netzwerkkomponenten?','Router, Switch, Access Point.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Router',1),(last_insert_rowid(),'Switch',1),(last_insert_rowid(),'Access Point',1),(last_insert_rowid(),'Monitor',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (301,'gap','Ein ____ nutzt Dienste im Netzwerk.','Client.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Client',1);

-- 302 Hauptbestandteile von Computernetzen
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (302,'sc','Was ist ein Node?','Knotenpunkt im Netzwerk.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Kabel',0),(last_insert_rowid(),'Knotenpunkt im Netzwerk',1),(last_insert_rowid(),'Druckerpatrone',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (302,'tf','Jeder Host braucht eine Adresse.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (302,'mc','Welche Aufgaben hat ein Switch?','Verbindet Geräte, leitet Datenpakete.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Verbindet Geräte',1),(last_insert_rowid(),'Leitet Datenpakete',1),(last_insert_rowid(),'Vergibt IP-Adressen',0),(last_insert_rowid(),'Druckt Dokumente',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (302,'gap','Ein Router ____ Netze.','verbindet');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'verbindet',1);

-- 303 Computernetze im Überblick
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (303,'sc','Was ist ein LAN?','Lokales Netzwerk in einem Gebäude.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Weiträumiges Netz',0),(last_insert_rowid(),'Lokales Netzwerk in einem Gebäude',1),(last_insert_rowid(),'Virtuelles Netz',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (303,'tf','Ein Peer-to-Peer-Netz hat keine zentrale Steuerung.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (303,'mc','Welche Netztypen gibt es?','LAN, WAN, MAN, PAN.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'LAN',1),(last_insert_rowid(),'WAN',1),(last_insert_rowid(),'MAN',1),(last_insert_rowid(),'Desktop',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (303,'gap','Ein VPN ist ein ____ durchs Internet.','sicherer Tunnel');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'sicherer Tunnel',1);

-- 304 Rechenzentren & Serversysteme
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (304,'sc','Was ist Colocation?','Eigene Hardware im fremden Rechenzentrum.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Cloud-Backup',0),(last_insert_rowid(),'Eigene Hardware im fremden Rechenzentrum',1),(last_insert_rowid(),'Virtuelles LAN',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (304,'tf','Ein File-Server stellt Speicherplatz für Dateien bereit.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (304,'mc','Welche Servertypen gibt es?','File, Print, Mail, DNS, Web, Terminal, NAS.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'File',1),(last_insert_rowid(),'Print',1),(last_insert_rowid(),'Mail',1),(last_insert_rowid(),'Monitor',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (304,'gap','Ein ____-Server verwaltet Druckaufträge.','Print');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Print',1);

-- 305 Clients im Überblick
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (305,'sc','Was ist ein Fat Client?','Leistungsfähiger PC mit eigener Rechenleistung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Minimal-Hardware',0),(last_insert_rowid(),'Leistungsfähiger PC mit eigener Rechenleistung',1),(last_insert_rowid(),'Nur Netzwerk',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (305,'tf','Zero Clients haben kein eigenes Betriebssystem.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (305,'mc','Welche mobilen Clients gibt es?','Notebook, Tablet, Smartphone.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Notebook',1),(last_insert_rowid(),'Tablet',1),(last_insert_rowid(),'Smartphone',1),(last_insert_rowid(),'Server',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (305,'gap','BYOD steht für Bring Your ____ Device.','Own');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Own',1);

-- 306 Grundlagen der Datenübertragung
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (306,'sc','Was ist Bandbreite?','Übertragungskapazität.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Übertragungskapazität',1),(last_insert_rowid(),'Signalgeschwindigkeit',0),(last_insert_rowid(),'Datenrate',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (306,'tf','Simplex bedeutet Übertragung in beide Richtungen gleichzeitig.','Falsch: nur eine Richtung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',0),(last_insert_rowid(),'Falsch',1);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (306,'mc','Welche Übertragungsarten gibt es?','Seriell, Parallel, Simplex, Duplex.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Seriell',1),(last_insert_rowid(),'Parallel',1),(last_insert_rowid(),'Simplex',1),(last_insert_rowid(),'Desktop',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (306,'gap','Unicast ist eine ____-zu-____ Kommunikation.','1:1');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'1:1',1);

-- 307 Netzwerkmedien & Topologien
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (307,'sc','Vorteil Glasfaser?','Hohe Geschwindigkeit, weite Strecken.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Billig',0),(last_insert_rowid(),'Hohe Geschwindigkeit, weite Strecken',1),(last_insert_rowid(),'Nur im Ring nutzbar',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (307,'tf','Kupferkabel ist günstiger als Glasfaser.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (307,'mc','Welche Topologien gibt es?','Stern, Bus, Ring, Masche, Zelle.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Stern',1),(last_insert_rowid(),'Bus',1),(last_insert_rowid(),'Ring',1),(last_insert_rowid(),'Desktop',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (307,'gap','Strukturierte ____ ist Standard im Unternehmen.','Verkabelung');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Verkabelung',1);

-- 308 Zugriffsverfahren & Ethernet
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (308,'sc','Was ist CSMA/CA?','Zugriff mit Kollisionsvermeidung.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Kollisionserkennung',0),(last_insert_rowid(),'Kollisionsvermeidung',1),(last_insert_rowid(),'Token',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (308,'tf','Ethernet ist weltweit Standard für LAN.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (308,'mc','Welche Zugriffsverfahren gibt es?','CSMA/CD, CSMA/CA, Token Passing.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'CSMA/CD',1),(last_insert_rowid(),'CSMA/CA',1),(last_insert_rowid(),'Token Passing',1),(last_insert_rowid(),'Simplex',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (308,'gap','Ethernet ist ____kompatibel und günstig.','abwärts');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'abwärts',1);

-- 309 Adressierung & Protokolle
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (309,'sc','Was ist eine MAC-Adresse?','Hardware-Adresse.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Hardware-Adresse',1),(last_insert_rowid(),'Logische Adresse',0),(last_insert_rowid(),'Protokoll',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (309,'tf','IPv6 bietet mehr Adressen als IPv4.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (309,'mc','Welche Protokolle gehören zur TCP/IP-Familie?','DHCP, DNS, HTTP.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'DHCP',1),(last_insert_rowid(),'DNS',1),(last_insert_rowid(),'HTTP',1),(last_insert_rowid(),'SMS',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (309,'gap','Ein Port ist eine ____ zur Anwendungserkennung.','Nummer');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Nummer',1);

-- 310 Sicherheit, Redundanz & Green IT
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (310,'sc','Was bedeutet Redundanz?','Doppelte Systeme zur Ausfallsicherheit.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Geringe Kosten',0),(last_insert_rowid(),'Doppelte Systeme zur Ausfallsicherheit',1),(last_insert_rowid(),'Nur Energiesparen',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (310,'tf','Backups schützen vor Datenverlust.','Wahr.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Wahr',1),(last_insert_rowid(),'Falsch',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (310,'mc','Was gehört zu Green IT?','Virtualisierung, energieeffiziente Geräte.');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Virtualisierung',1),(last_insert_rowid(),'Energieeffiziente Geräte',1),(last_insert_rowid(),'Datenverlust',0),(last_insert_rowid(),'Redundanz',0);
INSERT INTO questions(unit_id,type,stem,explanation) VALUES (310,'gap','Eine ____ schützt vor unbefugtem Zugriff.','Firewall');
INSERT INTO options(question_id,label,is_correct) VALUES (last_insert_rowid(),'Firewall',1);

COMMIT;
