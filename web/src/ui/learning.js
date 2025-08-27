// Learning-Ansicht
import { getLearningFields, getChapters, getTopics, getUnit } from '../api.js';

function spinner() {
	return `<div style="text-align:center;padding:2em"><div class="progress"><div class="progress-bar" style="width:100%"></div></div></div>`;
}

export function renderLearningFields(root) {
	root.innerHTML = spinner();
	let state = { lf: null, chapter: null, topic: null, lfs: [], chapters: [], topics: [], units: [] };

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
		if (!state.lf) {
			outlet.innerHTML = `
				<div class="card">
					<h2>Lernfelder</h2>
					<div id="lf-list" class="grid" style="display:grid; grid-template-columns: repeat(auto-fill,minmax(240px,1fr)); gap: 12px;"></div>
				</div>
				<div class="grid" style="display:grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-top:16px;">
					<div class="card"><h3>Kapitel</h3><div id="chapters"></div></div>
					<div class="card"><h3>Themen & Units</h3><div id="topics"></div></div>
				</div>
			`;
			content.innerHTML = `<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1.5rem;">
				${state.chapters.length ? state.chapters.map(ch => `
					<div class="card" style="cursor:pointer;" data-chapter="${ch.id}">
						<div style="font-weight:bold;">${ch.title}</div>
						<span class="muted">Kapitel ${ch.position}</span>
					</div>
				`).join('') : spinner()}
			</div>`;
		} else if (!state.topic) {
			content.innerHTML = `<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1.2rem;">
				${state.topics.length ? state.topics.map(tp => `
					<div class="card" style="cursor:pointer;" data-topic="${tp.id}">
						<div style="font-weight:bold;">${tp.title}</div>
						<span class="muted">Thema ${tp.position}</span>
					</div>
				`).join('') : spinner()}
			</div>`;
		} else {
			content.innerHTML = spinner();
			getUnits(state.topic.id);
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
				state.chapter = state.topic = null;
				content.innerHTML = spinner();
				state.chapters = await getChapters(state.lf.id);
				render();
			};
		});
		content.querySelectorAll('[data-chapter]').forEach(card => {
			card.onclick = async () => {
				state.chapter = state.chapters.find(ch => ch.id == card.dataset.chapter);
				state.topic = null;
				content.innerHTML = spinner();
				state.topics = await getTopics(state.chapter.id);
				render();
			};
		});
		content.querySelectorAll('[data-topic]').forEach(card => {
			card.onclick = async () => {
				state.topic = state.topics.find(tp => tp.id == card.dataset.topic);
				content.innerHTML = spinner();
				// Units laden
				getUnits(state.topic.id);
			};
		});
	}

	async function getUnits(topicId) {
		const res = await fetch(`/api/topics/${topicId}/units`);
		const units = await res.json();
		state.units = units;
		const content = root.querySelector('#learning-content');
		content.innerHTML = `<div style="margin-bottom:1.2em;">${units.length ? 'Einheiten:' : 'Keine Einheiten gefunden.'}</div>
			<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1.2rem;">
				${units.map(u => `
					<div class="card" style="cursor:pointer;" onclick="location.hash='/unit/${u.id}'">
						<div style="font-weight:bold;">${u.title}</div>
					</div>
				`).join('')}
			</div>`;
	}

	// Initial laden
	getLearningFields().then(lfs => {
		state.lfs = lfs;
		render();
	});
}

export function renderLearning(outlet) {
  outlet.innerHTML = `
    <div class="card">
      <h2>Lernfelder</h2>
      <p>Hier erscheinen gleich die Lernfelder, Kapitel und Units. (Platzhalter)</p>
      <div class="grid" style="display:grid; grid-template-columns: repeat(auto-fill,minmax(220px,1fr)); gap: 12px;">
        <div class="card">LF1 – Arbeitsplätze ausstatten</div>
        <div class="card">LF2 – Clients in Netzwerke einbinden</div>
        <div class="card">LF3 – Schutzmaßnahmen</div>
        <div class="card">LF4 – Datenbanken anpassen</div>
      </div>
    </div>
  `;
}
