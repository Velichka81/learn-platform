// Dashboard-Komponente
export function renderDashboard(outlet) {
	outlet.innerHTML = `
		<div class="grid grid--dash">
			<div class="card card--hero">
				<div>
					<h2>Weiterlernen</h2>
					<p>Heute fällige Karten warten auf dich.</p>
					<a class="button" href="#/flashcards">Jetzt starten</a>
				</div>
				<div class="ring" data-ring="70">70%</div>
			</div>

			<div class="card kpi">
				<div class="kpi__label">Fällige Karten</div>
				<div class="kpi__value">18</div>
			</div>
			<div class="card kpi">
				<div class="kpi__label">Diese Woche gelernt</div>
				<div class="kpi__value">124</div>
			</div>
			<div class="card kpi">
				<div class="kpi__label">AP1-Mock</div>
				<div class="kpi__value">62%</div>
			</div>

			<div class="card table-card">
				<div class="card__title">Nächste Einheiten</div>
				<table class="table">
					<thead><tr><th>Einheit</th><th>LF</th><th>Status</th></tr></thead>
					<tbody>
						<tr><td>Arbeitsplatz einrichten – Grundlagen</td><td>LF1</td><td><span class="badge">offen</span></td></tr>
						<tr><td>Netzwerk-Basics (OSI)</td><td>LF2</td><td><span class="badge badge--warn">teilweise</span></td></tr>
						<tr><td>Schutzbedarf & Grundschutz</td><td>LF4</td><td><span class="badge badge--ok">ok</span></td></tr>
					</tbody>
				</table>
			</div>

			<div class="card">
				<div class="card__title">Aktivität</div>
				<ul class="list">
					<li>3 Karten wiederholt • vor 5 Min</li>
					<li>Quiz LF1 abgeschlossen • vor 22 Min</li>
					<li>Neue Unit angelegt • gestern</li>
				</ul>
			</div>
		</div>
	`;
}
