#!/usr/bin/env node
import { getDb } from '../src/db.js';

/*
  Aktualisiert die Units (id 1..10) von LF1 mit neuen Inhalten.
  Erwartung: LF1 Struktur (Topics/Units) bereits vorhanden (z.B. durch reseed-lf1.js).
*/

const db = getDb();

// Definition der Inhalte für Units 1-10 (LF1)
// @typedef {{id:number, summary:string, html:string}} UnitData
/** @type {UnitData[]} */
const units = [
  {
    id:1,
    summary: 'Duales System: Praxis im Betrieb + Theorie in der Berufsschule, IHK überwacht und prüft.',
    html: `<h2>T1. IT-Ausbildung & duales System</h2>
<p>Die IT-Ausbildung in Deutschland folgt dem <strong>dualen System</strong>: zwei Lernorte arbeiten zusammen – <strong>Betrieb</strong> (Praxis) und <strong>Berufsschule</strong> (Theorie). Im Betrieb sammelst du praktische Erfahrungen (z.&nbsp;B. Programmieren, IT-Support, Netzwerke einrichten), während die Schule Grundlagen zu Technik, Prozessen und Wirtschaft vermittelt. Die <strong>IHK</strong> überwacht die Ausbildung, registriert Verträge, berät und führt die Prüfungen durch.</p>
<p>Ein zentraler Ordnungsrahmen sind die <strong>Lernfelder</strong>. Für die Abschlussprüfung Teil&nbsp;1 (AP1) sind vor allem die Lernfelder <strong>1–6</strong> relevant.</p>
<h3>Wichtig</h3>
<ul>
  <li><strong>Duales System</strong> = Praxis (Betrieb) + Theorie (Berufsschule)</li>
  <li><strong>IHK</strong> = Kontrolle, Beratung, Prüfungen</li>
  <li><strong>Ausbildungsvertrag</strong> muss bei der IHK eingetragen sein</li>
  <li><strong>AP1</strong> prüft Lernfelder 1–6</li>
</ul>`
  },
  {
    id:2,
    summary: 'Gestreckte Abschlussprüfung: AP1 (20%) + AP2 (Projekt, schriftlich, Fachgespräch) und drei Zeugnisse.',
    html: `<h2>T2. Gestreckte Abschlussprüfung & Zeugnisse</h2>
<p>Die IT-Berufe nutzen das Modell der <strong>gestreckten Abschlussprüfung</strong>. Sie besteht aus zwei Teilen:</p>
<ol>
  <li><strong>AP Teil 1</strong>: schriftlich, ca. 90 Minuten nach ~18 Monaten – Gewichtung <strong>20 %</strong>. Inhalte: Lernfelder 1–6 (Schwerpunkt „Arbeitsplatz einrichten“).</li>
  <li><strong>AP Teil 2</strong>: am Ende – Projektarbeit mit Dokumentation, Präsentation + Fachgespräch sowie schriftliche Prüfungen (Fachbereich + WISO).</li>
</ol>
<p>Am Ende erhältst du drei Zeugnisse:</p>
<ul>
  <li><strong>IHK-Zeugnis</strong> (rechtlich maßgeblich, enthält Gesamtnote)</li>
  <li><strong>Berufsschulzeugnis</strong> (Schulnoten)</li>
  <li><strong>Betriebszeugnis</strong> nach §16 BBiG (Tätigkeiten & Verhalten)</li>
</ul>
<h3>Wichtig</h3>
<ul>
  <li><strong>AP1</strong>: 90 Min – 20 % der Gesamtnote</li>
  <li><strong>AP2</strong>: Projekt + schriftlich + Fachgespräch</li>
  <li><strong>Zeugnisse</strong>: IHK, Berufsschule, Betrieb</li>
</ul>`
  },
  {
    id:3,
    summary: 'BBiG regelt Rechte & Pflichten: Azubi lernt & führt Berichtsheft, Betrieb bildet aus & stellt frei.',
    html: `<h2>T3. Rechte & Pflichten im Ausbildungsverhältnis</h2>
<p>Das <strong>Berufsbildungsgesetz (BBiG)</strong> regelt den Rahmen der dualen Ausbildung.</p>
<h3>Pflichten des Azubis</h3>
<ul>
  <li>Lernpflicht – aktiv mitarbeiten, Inhalte aneignen</li>
  <li>Berichtsheft (schriftliche / digitale Nachweise) führen</li>
  <li>Betriebliche Ordnung / Sicherheitsregeln beachten</li>
  <li>Geheimhaltung & Datenschutz einhalten</li>
</ul>
<h3>Pflichten des Ausbildenden</h3>
<ul>
  <li>Vermittlung aller Ausbildungsinhalte lt. Ausbildungsordnung</li>
  <li>Freistellung für Berufsschule & Prüfungen</li>
  <li>Bereitstellung notwendiger Arbeits- & Lernmittel</li>
  <li>Zeugnis ausstellen</li>
</ul>
<p>Der <strong>Ausbildungsvertrag</strong> (schriftlich, Registrierung bei der IHK) enthält u.&nbsp;a.: Ausbildungsziel, Dauer, Probezeit (1–4 Monate), Vergütung, Arbeitszeit, Urlaub, Kündigungsregeln.</p>
<h3>Wichtig</h3>
<ul>
  <li><strong>Azubi</strong>: Lernpflicht, Berichtsheft, Ordnung, Schweigepflicht</li>
  <li><strong>Betrieb</strong>: Ausbilden, Freistellen, Mittel bereitstellen, Zeugnis</li>
  <li><strong>Vertrag</strong>: Mindestinhalte §11 BBiG, IHK-Registrierung</li>
</ul>`
  },
  {
    id:4,
    summary: 'JArbSchG schützt unter 18: Arbeitszeit, Pausen, Urlaub, Freistellungen & Untersuchungen.',
    html: `<h2>T4. Jugendarbeitsschutzgesetz (JArbSchG)</h2>
<p>Das <strong>Jugendarbeitsschutzgesetz</strong> schützt Auszubildende unter 18 Jahren.</p>
<ul>
  <li><strong>Arbeitszeit</strong>: max. 8 h/Tag, 40 h/Woche (Ausgleich bis 8,5 h möglich)</li>
  <li><strong>Arbeitszeitraum</strong>: 6–20 Uhr (Ausnahmen branchenspezifisch)</li>
  <li><strong>Pausen</strong>: ab 4,5 h = 30 Min, ab 6 h = 60 Min (aufteilbar)</li>
  <li><strong>Urlaub</strong>: altersabhängig (mind. 25 Tage)</li>
  <li><strong>Freistellung</strong>: ganzer Berufsschultag (>5 Unterrichtsstunden); Tag vor schriftlicher Prüfung frei</li>
  <li><strong>Pflichtuntersuchungen</strong>: vor Beginn + Nachuntersuchung</li>
</ul>
<h3>Wichtig</h3>
<ul>
  <li>Max. 8 h / 40 h Woche (Ausnahmen begrenzt)</li>
  <li>Keine Nacht-/Sonn-/Feiertagsarbeit (mit Ausnahmen)</li>
  <li>Pausen 30–60 Min je nach Dauer</li>
  <li>Vor Prüfungstag frei</li>
</ul>`
  },
  {
    id:5,
    summary: 'Vergütung steigt jährlich; Abzüge führen zu Netto; Teilzeit-Ausbildung nach §8 BBiG möglich.',
    html: `<h2>T5. Vergütung & Teilzeitausbildung</h2>
<p>Die <strong>Ausbildungsvergütung</strong> ist gesetzlich abgesichert und steigt normalerweise mit jedem Ausbildungsjahr. Vom <strong>Brutto</strong> werden Steuern & Sozialabgaben abgezogen → verbleibt das <strong>Netto</strong>. Der Betrieb führt die Beiträge an Kranken-, Pflege-, Renten- und Arbeitslosenversicherung ab.</p>
<p><strong>Teilzeitausbildung (§8 BBiG)</strong>: Bei berechtigtem Interesse (z.&nbsp;B. Pflege, Kind, gesundheitliche Gründe) kann die tägliche / wöchentliche Ausbildungszeit reduziert werden. Antrag über die IHK – Ziel: Ausbildungsziel bleibt erreichbar.</p>
<h3>Wichtig</h3>
<ul>
  <li>Vergütung monatlich – steigt mit den Jahren</li>
  <li>Brutto ≠ Netto (Abzüge für Steuer & SV)</li>
  <li>Arbeitgeber führt Beiträge ab</li>
  <li>Teilzeit nach §8 BBiG möglich (IHK-Antrag)</li>
</ul>`
  },
  {
    id:6,
    summary: 'Zentrale Schutzgesetze: ArbZG, AGG, MiLoG, EntgFG, BUrlG, MuSchG/BEEG – Günstigkeitsprinzip beachten.',
    html: `<h2>T6. Arbeitsrecht-Basics</h2>
<p>Viele Gesetze sichern Arbeitnehmerrechte. Für Azubis gelten sie ergänzend zum BBiG.</p>
<ul>
  <li><strong>ArbZG</strong>: Arbeitszeiten, Pausen, Ruhezeiten</li>
  <li><strong>TzBfG</strong>: Teilzeit & Befristung</li>
  <li><strong>KSchG & §622 BGB</strong>: Kündigungsschutz & Fristen</li>
  <li><strong>AGG</strong>: Schutz vor Diskriminierung</li>
  <li><strong>MiLoG</strong>: Mindestlohn (Ausnahmen bei Azubis im 1. Jahr)</li>
  <li><strong>EntgFG</strong>: Lohnfortzahlung bei Krankheit</li>
  <li><strong>BUrlG</strong>: Mindesturlaub</li>
  <li><strong>MuSchG / BEEG</strong>: Mutterschutz & Elternzeit</li>
</ul>
<p><strong>Günstigkeitsprinzip</strong>: Bei mehreren Regelungen gilt die für dich günstigere (z.&nbsp;B. Tarifvertrag vs. Gesetz).</p>
<h3>Wichtig</h3>
<ul>
  <li>ArbZG: Arbeitszeit & Pausen</li>
  <li>AGG: Diskriminierungsschutz</li>
  <li>MiLoG: Mindestlohn</li>
  <li>EntgFG: Lohnfortzahlung</li>
  <li>Günstigkeitsprinzip beachten</li>
</ul>`
  },
  {
    id:7,
    summary: 'Mitbestimmung durch Betriebsrat; Tarifverträge regeln Arbeitsbedingungen; Streikrecht bei Gewerkschaften.',
    html: `<h2>T7. Mitbestimmung: Betriebsrat & Tarifrecht</h2>
<p>Der <strong>Betriebsrat (BR)</strong> kann ab 5 ständig wahlberechtigten Mitarbeitenden gewählt werden. Amtszeit: 4 Jahre. Er hat Mitbestimmungs- & Anhörungsrechte bei Einstellungen, Kündigungen, Arbeitszeitgestaltung, sozialen & organisatorischen Fragen.</p>
<p><strong>Tarifverträge</strong> zwischen Gewerkschaften & Arbeitgeberverbänden regeln u.&nbsp;a. Vergütung, Arbeitszeit, Urlaub. Während der Laufzeit gilt <strong>Friedenspflicht</strong>. Streiks dürfen nur von Gewerkschaften ausgerufen werden; Arbeitgeber können mit Aussperrung reagieren.</p>
<h3>Wichtig</h3>
<ul>
  <li>BR ab 5 Mitarbeitenden – Amtszeit 4 Jahre</li>
  <li>Mitbestimmung: Einstellungen, Kündigungen, Arbeitszeit</li>
  <li>Tarifverträge regeln Kernbedingungen</li>
  <li>Streikrecht nur Gewerkschaft</li>
  <li>Friedenspflicht während Tarifbindung</li>
</ul>`
  },
  {
    id:8,
    summary: 'JAV vertritt Azubis/Jugendliche, arbeitet eng mit BR zusammen, Amtszeit 2 Jahre.',
    html: `<h2>T8. Jugend- und Auszubildendenvertretung (JAV)</h2>
<p>Die <strong>JAV</strong> vertritt Interessen von Jugendlichen (<18) und Auszubildenden (bis 25) und arbeitet mit dem Betriebsrat zusammen.</p>
<ul>
  <li><strong>Wahlberechtigt</strong>: Azubis < 18 J. und Mitarbeitende bis 25 J.</li>
  <li><strong>Voraussetzung</strong>: mind. 5 Wahlberechtigte</li>
  <li><strong>Amtszeit</strong>: 2 Jahre</li>
  <li><strong>Aufgaben</strong>: Überwachung von BBiG, JArbSchG, BetrVG; Verbesserungsvorschläge; Teilnahme an BR-Sitzungen</li>
  <li>Kann BR-Beschlüsse 1 Woche aussetzen, wenn Azubi-Interessen betroffen</li>
</ul>
<h3>Wichtig</h3>
<ul>
  <li>JAV = Interessenvertretung</li>
  <li>Mind. 5 Wahlberechtigte erforderlich</li>
  <li>Amtszeit 2 Jahre</li>
  <li>Kooperation mit BR</li>
  <li>Aufschub von BR-Beschlüssen möglich</li>
</ul>`
  },
  {
    id:9,
    summary: 'Betrieb präsentieren: Zielgruppe, Rahmen, Quellen, Struktur, Medien, Storytelling beachten.',
    html: `<h2>T9. Betrieb präsentieren</h2>
<p>Azubis sollen den eigenen Betrieb überzeugend vorstellen können – z.&nbsp;B. in Schule, Prüfung oder Projekten.</p>
<ol>
  <li><strong>Zielgruppe</strong> definieren (Schüler, Prüfer, Kollegen)</li>
  <li><strong>Rahmenbedingungen</strong>: Zeit, Raum, Medien, Technik</li>
  <li><strong>Quellen</strong>: Website, interne Unterlagen, Interviews</li>
  <li><strong>Struktur</strong>: Einstieg – Hauptteil – Schluss</li>
  <li><strong>Medien</strong> bewusst einsetzen: Folien, Handout, Demo</li>
  <li><strong>Präsentationstechnik</strong>: klare Sprache, Storytelling, Körperhaltung</li>
</ol>
<h3>Wichtig</h3>
<ul>
  <li>Zielgruppe & Rahmen klären</li>
  <li>Saubere Struktur</li>
  <li>Medien gezielt</li>
  <li>Storytelling & Körpersprache</li>
</ul>`
  },
  {
    id:10,
    summary: 'Ausbildungsplan regelt Inhalte & Zeiten; Rotation fördert Überblick und steigende Verantwortung.',
    html: `<h2>T10. Ausbildungsplan & Rotation</h2>
<p>Der <strong>Ausbildungsplan</strong> basiert auf der Ausbildungsordnung und konkretisiert die sachliche & zeitliche Gliederung. Typisch ist eine <strong>Rotation</strong> durch Abteilungen (Support, Entwicklung, IT-Administration) für breiten Überblick. Mit der Zeit steigt die Eigenverantwortung – Ziel: selbstständige Projektarbeit zum Abschluss.</p>
<h3>Wichtig</h3>
<ul>
  <li>Ausbildungsplan Teil des Vertrags</li>
  <li>Sachliche & zeitliche Gliederung</li>
  <li>Abteilungsrotation</li>
  <li>Wachsende Verantwortung bis Projekt</li>
  <li>IHK überwacht Umsetzung</li>
</ul>`
  }
];

const update = db.prepare('UPDATE units SET summary = ?, content_html = ? WHERE id = ?');
const missing = [];

const check = db.prepare('SELECT id FROM units WHERE id = ?');

db.transaction(() => {
  for (const u of units) {
    if (!check.get(u.id)) { missing.push(u.id); continue; }
    update.run(u.summary, u.html, u.id);
  }
})();

if (missing.length) {
  console.warn('Folgende Unit-IDs fehlen, nichts aktualisiert:', missing.join(', '));
}
console.log('LF1 Units aktualisiert.');
