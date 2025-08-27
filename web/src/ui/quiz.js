import { startQuiz as apiStartQuiz, answer, finish } from '../api.js';

export async function renderQuizForUnit(root, unitId, options = { num: 10, timerSec: null }) {
	root.innerHTML = '<div class="card">Quiz wird geladen...</div>';
	const quiz = await apiStartQuiz('unit', { scopeRef: unitId, ...options });
	let idx = 0;
	let answers = {};
	let timer = quiz.timerSec, timerId = null;
	let finished = false, result = null;

	function render() {
		if (finished) {
			root.innerHTML = '<div class="card">Auswertung...</div>';
			finish(quiz.attempt_id).then(res => {
				result = res;
				root.innerHTML = `
					<div class="card" style="max-width:600px;margin:2em auto;">
						<h2>Ergebnis</h2>
						<div style="font-size:1.5em;font-weight:bold;">${Math.round(res.score*100)}%</div>
						<div class="muted">Richtige Antworten: ${Math.round(res.score*quiz.questions.length)} / ${quiz.questions.length}</div>
						<h3>Fehleranalyse</h3>
						<ul style="margin-bottom:1.5em;">
							${res.errors.map(e => `<li><b>Frage:</b> ${getStem(e.qid)}<br><b>Erklärung:</b> ${e.explanation||''}</li>`).join('')}
						</ul>
						<button class="button" disabled>Fehler als Lernkarten üben (bald)</button>
					</div>
				`;
			});
			return;
		}
		const q = quiz.questions[idx];
		root.innerHTML = `
			<div class="card" style="max-width:600px;margin:2em auto;">
				<div style="margin-bottom:1em;">Frage ${idx+1} / ${quiz.questions.length}</div>
				<div style="font-weight:bold;font-size:1.1em;margin-bottom:1.2em;">${q.stem}</div>
				<form id="quiz-form"></form>
				<div style="margin:1.2em 0;">
					<div class="progress"><div class="progress-bar" style="width:${Math.round((idx+1)/quiz.questions.length*100)}%"></div></div>
					${timer ? `<div style="float:right;">⏰ <span id="quiz-timer">${timer}</span>s</div>` : ''}
				</div>
				<div style="display:flex;gap:1.2em;justify-content:flex-end;">
					<button class="button ghost" type="button" id="next-btn">${idx+1<quiz.questions.length?'Weiter':'Abgeben'}</button>
				</div>
			</div>
		`;
		const form = root.querySelector('#quiz-form');
		// Render options
		if (q.type === 'sc') {
			form.innerHTML = q.options.map(opt => `<label style="display:block;margin-bottom:0.7em;"><input type="radio" name="opt" value="${opt.id}" ${answers[q.id]?.includes(opt.id)?'checked':''}/> ${opt.label}</label>`).join('');
		} else if (q.type === 'mc') {
			form.innerHTML = q.options.map(opt => `<label style="display:block;margin-bottom:0.7em;"><input type="checkbox" name="opt" value="${opt.id}" ${answers[q.id]?.includes(opt.id)?'checked':''}/> ${opt.label}</label>`).join('');
		} else if (q.type === 'tf') {
			form.innerHTML = q.options.map(opt => `<button type="button" class="button" data-opt="${opt.id}">${opt.label}</button>`).join(' ');
			form.querySelectorAll('button').forEach(btn => {
				btn.onclick = async () => {
					answers[q.id] = [Number(btn.dataset.opt)];
					await answer(quiz.attempt_id, q.id, Number(btn.dataset.opt));
					next();
				};
			});
		}
		// Option-Handler
		if (q.type === 'sc' || q.type === 'mc') {
			form.onchange = async () => {
				const vals = Array.from(form.querySelectorAll('input:checked')).map(i=>Number(i.value));
				answers[q.id] = vals;
				// Bei SC sofort answer, bei MC erst beim Weiter
				if (q.type === 'sc' && vals.length) await answer(quiz.attempt_id, q.id, vals[0]);
			};
		}
		// Weiter/Abgeben
		root.querySelector('#next-btn').onclick = async () => {
			if (!answers[q.id] || !answers[q.id].length) return alert('Bitte eine Antwort wählen!');
			if (q.type === 'mc') {
				for (const oid of answers[q.id]) await answer(quiz.attempt_id, q.id, oid);
			}
			if (idx+1 < quiz.questions.length) { idx++; render(); }
			else { finished = true; render(); }
		};
		// Timer
		if (timer && !timerId) {
			timerId = setInterval(() => {
				timer--;
				const el = root.querySelector('#quiz-timer');
				if (el) el.textContent = timer;
				if (timer <= 0) {
					clearInterval(timerId);
					finished = true; render();
				}
			}, 1000);
		}
	}
	function getStem(qid) {
		const q = quiz.questions.find(q => q.id === qid);
		return q ? q.stem : '';
	}
	render();
}

export async function startQuiz(scope, opts) {
	return apiStartQuiz(scope, opts);
}

export function renderQuizHome(outlet) {
  outlet.innerHTML = `
    <div class="card">
      <h2>Quiz</h2>
      <p>Wähle einen Modus oder starte ein Unit-Quiz.</p>
      <div style="display:flex; gap:12px; flex-wrap:wrap;">
        <a class="button" href="#/ap1">AP1-Training</a>
        <a class="button" href="#/ap2">AP2-Training</a>
      </div>
    </div>
  `;
}

export function renderApMode(outlet, mode) {
  outlet.innerHTML = `
    <div class="card">
      <h2>${mode.toUpperCase()} – Prüfungstraining</h2>
      <p>Konfiguriere Fragenanzahl und starte.</p>
      <div style="display:flex; gap:8px; align-items:center;">
        <label>Fragen: <input type="number" id="qnum" value="20" min="5" max="60" style="width:80px"></label>
        <button class="button" id="start">Starten</button>
      </div>
    </div>
  `;
  document.getElementById('start').addEventListener('click', () => {
    alert(`Starte ${mode.toUpperCase()} mit ${document.getElementById('qnum').value} Fragen (Platzhalter).`);
  });
}
// Quiz-Runner
