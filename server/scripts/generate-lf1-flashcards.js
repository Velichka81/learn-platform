#!/usr/bin/env node
import { getDb } from '../src/db.js';

/*
  Generiert Flashcards für LF1 Units (IDs 1-10).
  Vorgehen:
    - Vorhandene Flashcards dieser Units löschen
    - Neue Karten (10-15 pro Unit) einfügen
  Wiederholbarer, idempotenter Ablauf (außer Autoincrement IDs wachsen weiter – für Lernlogik irrelevant).
*/

const db = getDb();

const unitsFlashcards = {
  1: [
    ['Was kennzeichnet das duale System?','Verzahnung von betrieblicher Praxis und schulischer Theorie.'],
    ['Welche Institution überwacht die Ausbildung?','Die IHK (Industrie- und Handelskammer).'],
    ['Welche zwei Lernorte gibt es?','Betrieb und Berufsschule.'],
    ['Was macht die IHK u.a.?','Verträge registrieren, beraten, Prüfungen organisieren.'],
    ['Welche Lernfelder sind für AP1 besonders wichtig?','Lernfelder 1–6.'],
    ['Was bringt dir der Betrieb hauptsächlich?','Praktische Erfahrungen (Programmieren, Support, Netzwerke).'],
    ['Was vermittelt primär die Berufsschule?','Theoretische Grundlagen (Technik, Prozesse, Wirtschaft).'],
    ['Warum gibt es Lernfelder?','Strukturierung der schulischen Theorie nach Handlungsfeldern.'],
    ['Was ist Voraussetzung für eine gültige Ausbildung?','Eingetragener Ausbildungsvertrag bei der IHK.'],
    ['Wann lernst du typischerweise Praxisinhalte?','Während der Arbeit im Betrieb.'],
    ['Nenne ein Beispiel für betriebliche Tätigkeit.','IT-Support leisten / Netzwerk einrichten / Code entwickeln.'],
    ['Wer führt die Abschlussprüfungen durch?','Die IHK.']
  ],
  2: [
    ['Seit wann gibt es die gestreckte Abschlussprüfung?','Seit 2020 (Neuregelung IT-Berufe).'],
    ['Aus welchen Teilen besteht die Abschlussprüfung?','AP Teil 1 und AP Teil 2.'],
    ['Wie lange dauert AP Teil 1?','Etwa 90 Minuten.'],
    ['Wann findet AP Teil 1 ungefähr statt?','Nach ca. 18 Monaten.'],
    ['Wie stark wird AP Teil 1 gewichtet?','Mit 20 % der Endnote.'],
    ['Welche Inhalte umfasst AP Teil 1?','Lernfelder 1–6, Schwerpunkt Arbeitsplatz einrichten.'],
    ['Was umfasst AP Teil 2?','Projektarbeit + Doku, Präsentation/Fachgespräch, schriftliche Prüfungen (Fach + WISO).'],
    ['Welche drei Zeugnisse bekommst du?','IHK-Zeugnis, Berufsschulzeugnis, Betriebszeugnis (§16 BBiG).'],
    ['Welches Zeugnis ist rechtlich maßgeblich?','Das IHK-Zeugnis.'],
    ['Was bewertet das Betriebszeugnis?','Tätigkeiten und Verhalten im Betrieb.'],
    ['Welcher Teil enthält Projekt und Fachgespräch?','AP Teil 2.'],
    ['Wofür steht WISO?','Wirtschafts- und Sozialkunde.']
  ],
  3: [
    ['Welches Gesetz regelt die duale Ausbildung?','Das Berufsbildungsgesetz (BBiG).'],
    ['Nenne eine Pflicht des Azubis.','Lernpflicht / Berichtsheft führen / Ordnung einhalten / Schweigepflicht.'],
    ['Wer muss das Berichtsheft führen?','Der Auszubildende.'],
    ['Was muss der Betrieb laut BBiG sicherstellen?','Vermittlung aller Ausbildungsinhalte laut Ordnung.'],
    ['Wofür muss der Betrieb freistellen?','Berufsschule und Prüfungen.'],
    ['Was muss der Betrieb bereitstellen?','Erforderliche Arbeits- und Lernmittel.'],
    ['Was erhält der Azubi am Ende vom Betrieb?','Ein Zeugnis (Qualifikations- oder Arbeitszeugnis).'],
    ['Wie lange darf die Probezeit sein?','Zwischen 1 und 4 Monaten.'],
    ['Was enthält der Ausbildungsvertrag?','Ziele, Dauer, Probezeit, Vergütung, Arbeitszeit, Urlaub, Kündigung.'],
    ['Wo muss der Vertrag eingetragen werden?','Bei der IHK.'],
    ['Warum Schweigepflicht?','Zum Schutz von Betriebs- und Geschäftsgeheimnissen.'],
    ['Wer kontrolliert die Einhaltung des Vertrags?','Die IHK als Aufsichtsinstanz.']
  ],
  4: [
    ['Wen schützt das Jugendarbeitsschutzgesetz?','Jugendliche unter 18 Jahren in Ausbildung.'],
    ['Maximale tägliche Arbeitszeit laut JArbSchG?','8 Stunden (Ausgleich bis 8,5 möglich).'],
    ['Maximale Wochenarbeitszeit?','40 Stunden.'],
    ['Zulässiger Arbeitszeitraum?','Grundsätzlich 6–20 Uhr.'],
    ['Ab wann 30 Minuten Pause?','Ab mehr als 4,5 Stunden Arbeitszeit.'],
    ['Ab wann 60 Minuten Pause?','Ab mehr als 6 Stunden Arbeitszeit.'],
    ['Wie viele Urlaubstage mindestens unter 18?','Mindestens 25 (je nach Alter).'],
    ['Wann gibt es einen freien Tag vor Prüfung?','Am Tag vor der schriftlichen Abschlussprüfung.'],
    ['Welche Pflicht besteht vor Ausbildungsbeginn?','Erstuntersuchung (ärztlich).'],
    ['Was passiert bei Verstößen gegen JArbSchG?','Behördliche Maßnahmen / Bußgelder für den Betrieb.'],
    ['Warum besondere Schutzvorschriften?','Gesundheit & Entwicklung Jugendlicher sichern.'],
    ['Darf Nachtarbeit geleistet werden?','Grundsätzlich nein, Ausnahmen branchenspezifisch.']
  ],
  5: [
    ['Was ist die Ausbildungsvergütung?','Monatliche Zahlung an den Azubi für die Ausbildung.'],
    ['Wie entwickelt sich die Vergütung?','Steigt mit jedem Ausbildungsjahr.'],
    ['Was bedeutet Brutto?','Vergütung vor Abzügen.'],
    ['Was bedeutet Netto?','Auszahlungsbetrag nach Steuern & Sozialabgaben.'],
    ['Wer führt Sozialbeiträge ab?','Der Arbeitgeber.'],
    ['Welche Versicherungen sind enthalten?','Kranken-, Pflege-, Renten-, Arbeitslosenversicherung.'],
    ['Was regelt §8 BBiG?','Möglichkeit der Teilzeitausbildung.'],
    ['Wann ist Teilzeit möglich?','Bei berechtigtem Interesse (Familie, Gesundheit etc.).'],
    ['Wer genehmigt Teilzeit?','Die IHK (Antrag).'],
    ['Bleibt Ziel trotz Teilzeit gleich?','Ja, Ausbildungsziel unverändert.'],
    ['Was kann durch Teilzeit länger werden?','Gesamtdauer der Ausbildung (ggf. Verlängerung).'],
    ['Warum steigen Vergütungen jährlich?','Anpassung an wachsende Qualifikation und Motivation.']
  ],
  6: [
    ['Was regelt das ArbZG?','Arbeitszeiten, Pausen und Ruhezeiten.'],
    ['Wogegen schützt das AGG?','Diskriminierung (z.B. Herkunft, Geschlecht, Religion).'],
    ['Was sichert das EntgFG?','Lohnfortzahlung im Krankheitsfall.'],
    ['Was legt das BUrlG fest?','Mindesturlaub.'],
    ['Was ist der Mindestlohn?','Gesetzlich festgelegte Untergrenze der Vergütung.'],
    ['Wer ist vom Mindestlohn ausgenommen?','Teilweise Azubis im 1. Jahr (Mindestausbildungsvergütung greift).'],
    ['Was regelt das TzBfG?','Teilzeit- und Befristungsmöglichkeiten.'],
    ['Was schützt das KSchG?','Vor sozial ungerechtfertigten Kündigungen.'],
    ['Wozu dient das Günstigkeitsprinzip?','Günstigere von mehreren Regelungen gilt.'],
    ['Was regelt MuSchG?','Schutz werdender Mütter.'],
    ['Wofür steht BEEG?','Bundeselterngeld- und Elternzeitgesetz.'],
    ['Warum mehrere Gesetze relevant?','Schutz verschiedener Aspekte des Arbeitsverhältnisses.']
  ],
  7: [
    ['Ab wann kann ein Betriebsrat gewählt werden?','Ab 5 ständig wahlberechtigten Mitarbeitenden.'],
    ['Wie lange ist die Amtszeit des BR?','4 Jahre.'],
    ['Nenne ein Mitbestimmungsrecht.','Einstellungen / Kündigungen / Arbeitszeit / Soziales.'],
    ['Wer schließt Tarifverträge?','Gewerkschaften und Arbeitgeberverbände.'],
    ['Was regeln Tarifverträge?','Arbeitszeit, Urlaub, Vergütung etc.'],
    ['Was ist Friedenspflicht?','Keine Arbeitskampfmaßnahmen während Tariflaufzeit.'],
    ['Wer darf Streiks ausrufen?','Nur Gewerkschaften.'],
    ['Was ist eine Aussperrung?','Gegenmaßnahme des Arbeitgebers im Arbeitskampf.'],
    ['Vorteil von Tarifbindung?','Planbare, meist bessere Bedingungen.'],
    ['Wozu dient Mitbestimmung?','Schutz und Beteiligung der Belegschaft.'],
    ['Was passiert ohne BR?','Weniger formalisierte Beteiligung der Mitarbeitenden.'],
    ['Was fördert der BR?','Sozialverträgliche Entscheidungen & Kommunikation.']
  ],
  8: [
    ['Was ist die JAV?','Jugend- und Auszubildendenvertretung.'],
    ['Wer ist wahlberechtigt für die JAV?','Azubis <18 & Mitarbeitende bis 25 Jahre.'],
    ['Mindestvoraussetzung zur JAV-Gründung?','Mindestens 5 Wahlberechtigte.'],
    ['Wie lange ist die Amtszeit der JAV?','2 Jahre.'],
    ['Mit wem arbeitet die JAV eng zusammen?','Mit dem Betriebsrat.'],
    ['Nenne eine JAV-Aufgabe.','Überwachung BBiG/JArbSchG/BetrVG / Verbesserungsvorschläge.'],
    ['Kann die JAV BR-Beschlüsse verzögern?','Ja, um eine Woche.'],
    ['Warum JAV wichtig?','Spezielle Vertretung der Interessen junger Beschäftigter.'],
    ['Was ist BetrVG?','Betriebsverfassungsgesetz.'],
    ['Was erreicht Aufschub eines Beschlusses?','Nochmalige Prüfung aus Azubi-Sicht.'],
    ['Wie stärkt JAV die Ausbildung?','Durch Feedback und Verbesserungsanträge.'],
    ['Wer profitiert von JAV-Arbeit?','Azubis und Betrieb (Qualität der Ausbildung).']
  ],
  9: [
    ['Erster Schritt einer Präsentation?','Zielgruppe definieren.'],
    ['Was klärst du bei Rahmenbedingungen?','Zeit, Raum, Technik, Medien.'],
    ['Warum Zielgruppe wichtig?','Inhalt/Ton anpassen für Wirkung.'],
    ['Kernstruktur einer Präsentation?','Einstieg – Hauptteil – Schluss.'],
    ['Was sind geeignete Quellen?','Website, interne Unterlagen, Interviews.'],
    ['Wozu dienen Medien?','Visualisierung und Unterstützung der Aussagen.'],
    ['Was verbessert die Verständlichkeit?','Klare Sprache & Storytelling.'],
    ['Warum Körpersprache?','Unterstützt Glaubwürdigkeit und Aufmerksamkeit.'],
    ['Was macht einen guten Einstieg aus?','Aufmerksamkeit wecken (Frage, Beispiel).'],
    ['Welche Fehler vermeiden?','Überladene Folien / Monotonie.'],
    ['Warum ein Handout?','Nachhaltige Sicherung der Kernaussagen.'],
    ['Was gehört in den Schluss?','Zusammenfassung & Call-to-Action / Dank.']
  ],
  10: [
    ['Was ist der Ausbildungsplan?','Konkretisierung der sachlichen & zeitlichen Gliederung.'],
    ['Worauf basiert der Plan?','Auf der Ausbildungsordnung.'],
    ['Warum Rotation?','Breiter Überblick über Prozesse & Abteilungen.'],
    ['Typische Stationen in IT?','Support, Entwicklung, Administration.'],
    ['Was wächst mit der Zeit?','Eigenverantwortung.'],
    ['Ziel zum Ende der Ausbildung?','Selbstständige Projektarbeit.'],
    ['Wer überwacht Umsetzung?','Die IHK.'],
    ['Vorteil der Rotation?','Verständnis für Zusammenhänge & Zusammenarbeit.'],
    ['Was dokumentiert Fortschritt?','Berichtsheft / Feedbackgespräche.'],
    ['Warum Plan anpassen?','Bei Veränderungen oder besonderen Stärken/Bedarfen.'],
    ['Was fördert Eigenverantwortung?','Frühe Teilaufgaben & reflektiertes Feedback.'],
    ['Was zeigt Plantransparenz?','Verlässlichkeit und Professionalität der Ausbildung.']
  ]
};

const deleteStmt = db.prepare('DELETE FROM flashcards WHERE unit_id = ?');
const insertStmt = db.prepare('INSERT INTO flashcards (unit_id, question, answer, difficulty) VALUES (?,?,?,?)');

db.transaction(() => {
  for (const unitId of Object.keys(unitsFlashcards)) {
    deleteStmt.run(unitId);
    const cards = unitsFlashcards[unitId];
    for (const [q,a] of cards) {
      // einfache Heuristik difficulty: Länge der Antwort
      const diff = a.length < 40 ? 1 : (a.length < 80 ? 2 : 3);
      insertStmt.run(unitId, q, a, diff);
    }
  }
})();

for (const unitId of Object.keys(unitsFlashcards)) {
  const count = db.prepare('SELECT COUNT(*) c FROM flashcards WHERE unit_id = ?').get(unitId).c;
  console.log(`Unit ${unitId}: ${count} Karten eingetragen.`);
}

console.log('Flashcards für LF1 erzeugt.');
