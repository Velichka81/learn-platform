// Learning-Ansicht
import { getLearningFields, getChapters, getTopics, getUnit } from '../api.js';

function spinner() {
	return `<div style="text-align:center;padding:2em"><div class="progress"><div class="progress-bar" style="width:100%"></div></div></div>`;
}

export function renderLearningFields(root) {
	root.innerHTML = spinner();
	let state = { lf: null, chapter: null, topic: null, lfs: [], chapters: [], topics: [], unit: null, error: null };

	function render() {
		root.innerHTML = `
			<div style="margin-bottom:1.5em;">
				<nav class="breadcrumbs">
					<a href="#/learning">Lernfelder</a>
					${state.lf ? `&nbsp;›&nbsp;<a href="#" data-bc="lf">${state.lf.title}</a>` : ''}
					${state.chapter ? `&nbsp;›&nbsp;<a href="#" data-bc="chapter">${state.chapter.title}</a>` : ''}
					${state.topic ? `&nbsp;›&nbsp;<a href="#" data-bc="topic">${state.topic.title}</a>` : ''}
				</nav>
			</div>
			<div id="learning-content"></div>
		`;
		const content = root.querySelector('#learning-content');
		if (state.error) {
			content.innerHTML = `<div class="card" style="border:1px solid var(--danger);">
				<h3 style="margin-top:0;color:var(--danger);">Fehler beim Laden</h3>
				<p>${state.error}</p>
				<button id="retry-load" class="button small">Erneut versuchen</button>
			</div>`;
			const retry = content.querySelector('#retry-load');
			if (retry) retry.onclick = () => initialLoad();
		} else if (!state.lf) {
			// Nur LF1 zeigen
			const lf1 = state.lfs.find(l => l.id === 1001 || l.code === 'LF1') || state.lfs[0];
			content.innerHTML = lf1 ? `
				<div class="card" data-lf="${lf1.id}" style="cursor:pointer;">
					<h2 style="margin-top:0;">${lf1.title}</h2>
					<div class="muted">${lf1.code}</div>
					<p style="margin-top:.75em;">Klicken um Kapitel & Themen anzuzeigen.</p>
				</div>
			` : '<div class="muted">Kein Lernfeld gefunden.</div>';
		} else if (!state.chapter) {
			content.innerHTML = `<h3>Kapitel</h3>
			<div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:1rem;">
			${state.chapters.map(ch => `
				<div class="card" data-chapter="${ch.id}" style="cursor:pointer;">
					<div style="font-weight:bold;">${ch.title}</div>
					<span class="muted">Kapitel ${ch.position}</span>
				</div>`).join('')}
			</div>`;
		} else if (!state.topic) {
			content.innerHTML = `<h3>Themen (LF1)</h3>
			<div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:1rem;">
			${state.topics.map(tp => `
				<div class="card" data-topic="${tp.id}" style="cursor:pointer;">
					<div style="font-weight:bold;">${tp.title}</div>
					<span class="muted">Thema ${tp.position}</span>
				</div>`).join('')}
			</div>`;
		} else if (state.unit) {
			content.innerHTML = `<div class="card">
				<h3 style="margin-top:0;">${state.unit.title}</h3>
				<div class="muted" style="margin-bottom:.75em;">Thema ${state.topic.position}</div>
				${state.unit.content_html || '<p><em>Kein Inhalt hinterlegt.</em></p>'}
				<div style="margin-top:1.5em;"><button id="back-topics" class="button ghost">Zurück zu den Themen</button></div>
			</div>`;
			const backBtn = content.querySelector('#back-topics');
			if (backBtn) backBtn.onclick = () => { state.unit = null; state.topic = null; render(); };
		} else {
			// Fallback: falls weder Unit noch Topics gerendert wurden, zeige Topics
			if (state.chapter) {
				content.innerHTML = `<h3>Themen (LF1)</h3>
				<div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:1rem;">
				${state.topics.map(tp => `
					<div class="card" data-topic="${tp.id}" style="cursor:pointer;">
						<div style="font-weight:bold;">${tp.title}</div>
						<span class="muted">Thema ${tp.position}</span>
					</div>`).join('')}
				</div>`;
			}
		}
		// Breadcrumb-Clicks
		root.querySelectorAll('.breadcrumbs a[data-bc]').forEach(a => {
			a.onclick = e => {
				e.preventDefault();
				if (a.dataset.bc === 'lf') { state.chapter = state.topic = null; render(); }
				else if (a.dataset.bc === 'chapter') { state.topic = null; render(); }
				else if (a.dataset.bc === 'topic') { render(); }
			};
		});
		// Card-Clicks
		content.querySelectorAll('[data-lf]').forEach(card => {
			card.onclick = async () => {
				state.lf = state.lfs.find(lf => lf.id == card.dataset.lf);
				state.chapter = state.topic = state.unit = null;
				content.innerHTML = spinner();
				try {
					state.chapters = await getChapters(state.lf.id);
					// Wenn nur ein Kapitel existiert, direkt Themen laden
					if (state.chapters.length === 1) {
						state.chapter = state.chapters[0];
						state.topics = await getTopics(state.chapter.id);
					}
					render();
				} catch (e) {
					content.innerHTML = `<div class="error">Fehler beim Laden der Kapitel: ${e.message}</div>`;
				}
			};
		});
		content.querySelectorAll('[data-chapter]').forEach(card => {
			card.onclick = async () => {
				state.chapter = state.chapters.find(ch => ch.id == card.dataset.chapter);
				state.topic = state.unit = null;
				content.innerHTML = spinner();
				state.topics = await getTopics(state.chapter.id);
				render();
			};
		});
		content.querySelectorAll('[data-topic]').forEach(card => {
			card.onclick = async () => {
				state.topic = state.topics.find(tp => tp.id == card.dataset.topic);
				content.innerHTML = spinner();
				try {
					// Units-Route liegt (nach Reset) unter /api/learning-fields/topics/:id/units
					const unitsRes = await fetch(`/api/learning-fields/topics/${state.topic.id}/units`);
					if (!unitsRes.ok) throw new Error(`HTTP ${unitsRes.status}`);
					const units = await unitsRes.json();
					if (units.length) {
						state.unit = await getUnit(units[0].id);
					} else {
						state.unit = { title: state.topic.title, content_html: '<p><em>Keine Unit hinterlegt.</em></p>' };
					}
					render();
				} catch (e) {
					content.innerHTML = `<div class="error">Fehler beim Laden der Unit: ${e.message}</div>`;
				}
			};
		});
	}

	// getUnits entfällt – direkte Anzeige einer einzelnen Unit


	async function initialLoad() {
		root.innerHTML = spinner();
		state = { lf: null, chapter: null, topic: null, lfs: [], chapters: [], topics: [], unit: null, error: null };
		try {
			const lfs = await getLearningFields();
			state.lfs = Array.isArray(lfs) ? lfs : [];
			// Auto-Open wenn nur ein Lernfeld
			if (state.lfs.length === 1) {
				state.lf = state.lfs[0];
				try {
					state.chapters = await getChapters(state.lf.id);
					if (state.chapters.length === 1) {
						state.chapter = state.chapters[0];
						state.topics = await getTopics(state.chapter.id);
					}
				} catch (e) { /* Kapitel-Fehler ignorieren */ }
			}
		} catch (e) {
			state.error = e.message || 'Unbekannter Fehler';
		}
		render();
	}

	initialLoad();
}

export function renderLearning(outlet) {
	renderLearningFields(outlet);
}
