import { startQuiz as apiStartQuiz, answer, finish, getLearningFields, getMe } from '../api.js';

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

// Generic renderer used by unit.js (expects quiz object from API startQuiz already fetched)
export function renderQuiz(root, quiz) {
	let idx = 0;
	let answers = {}; let finished = false; let timer = quiz.timerSec; let timerId = null;
	if (!quiz.questions || !quiz.questions.length) {
		root.innerHTML = '<div class="card">Keine Fragen gefunden (dieses Lernfeld / Filter leer). Bitte Seeds prüfen.</div>';
		return;
	}
	function render() {
		if (finished) {
			root.innerHTML = '<div class="card">Auswertung...</div>';
			finish(quiz.attempt_id).then(res => {
				root.innerHTML = `<div class="card" style="max-width:600px;margin:2em auto;">`+
					`<h2>Ergebnis</h2><div style="font-size:1.5em;font-weight:bold;">${Math.round(res.score*100)}%</div>`+
					`<div class="muted">Richtig: ${Math.round(res.score*quiz.questions.length)} / ${quiz.questions.length}</div>`+
					`<h3>Fehleranalyse</h3><ul>`+
						res.errors.map(e=>`<li><b>Frage:</b> ${getStem(e.qid)}<br><b>Erklärung:</b> ${e.explanation||''}</li>`).join('')+
					`</ul>`+
					`</div>`;
			}); return;
		}
		const q = quiz.questions[idx];
		root.innerHTML = `<div class="card" style="max-width:600px;margin:2em auto;">`+
			`<div style="margin-bottom:1em;">Frage ${idx+1} / ${quiz.questions.length}</div>`+
			`<div style="font-weight:bold;font-size:1.1em;margin-bottom:1.2em;">${q.stem}</div>`+
			`<form id="quiz-form"></form>`+
			`<div style="margin:1.2em 0;">`+
			`<div class="progress"><div class="progress-bar" style="width:${Math.round((idx+1)/quiz.questions.length*100)}%"></div></div>`+
			`${timer ? `<div style="float:right;">⏰ <span id="quiz-timer">${timer}</span>s</div>` : ''}`+
			`</div>`+
			`<div style="display:flex;gap:1.2em;justify-content:flex-end;">`+
			`<button class="button ghost" type="button" id="next-btn">${idx+1<quiz.questions.length?'Weiter':'Abgeben'}</button>`+
			`</div>`+
			`</div>`;
		const form = root.querySelector('#quiz-form');
		if (q.type==='sc') form.innerHTML = q.options.map(o=>`<label style="display:block;margin-bottom:.7em;"><input type="radio" name="opt" value="${o.id}" ${answers[q.id]?.includes(o.id)?'checked':''}/> ${o.label}</label>`).join('');
		else if (q.type==='mc') form.innerHTML = q.options.map(o=>`<label style="display:block;margin-bottom:.7em;"><input type="checkbox" name="opt" value="${o.id}" ${answers[q.id]?.includes(o.id)?'checked':''}/> ${o.label}</label>`).join('');
		else if (q.type==='tf') {
			form.innerHTML = q.options.map(o=>`<button type="button" class="button" data-opt="${o.id}">${o.label}</button>`).join(' ');
			form.querySelectorAll('button').forEach(btn=>btn.onclick=async()=>{answers[q.id]=[Number(btn.dataset.opt)];await answer(quiz.attempt_id,q.id,Number(btn.dataset.opt));next();});
		}
		if (q.type==='sc'||q.type==='mc') form.onchange=async()=>{const vals=[...form.querySelectorAll('input:checked')].map(i=>Number(i.value));answers[q.id]=vals;if(q.type==='sc'&&vals.length)await answer(quiz.attempt_id,q.id,vals[0]);};
		root.querySelector('#next-btn').onclick=async()=>{if(!answers[q.id]?.length)return alert('Bitte eine Antwort wählen!');if(q.type==='mc'){for(const oid of answers[q.id])await answer(quiz.attempt_id,q.id,oid);}if(idx+1<quiz.questions.length){idx++;render();}else{finished=true;render();}};
		if(timer && !timerId){timerId=setInterval(()=>{timer--;const el=root.querySelector('#quiz-timer');if(el) el.textContent=timer;if(timer<=0){clearInterval(timerId);finished=true;render();}},1000);}  }
	function getStem(id){const q=quiz.questions.find(x=>x.id===id);return q?q.stem:'';}
	function next(){if(idx+1<quiz.questions.length){idx++;render();}else{finished=true;render();}}
	render();
}

export async function startQuiz(scope, opts) {
	return apiStartQuiz(scope, opts);
}

export function renderQuizHome(outlet) {
	outlet.innerHTML = `
		<div class="card" id="quiz-home">
			<h2 style="margin-top:0;">Quiz</h2>
			<p style="margin:0 0 1rem 0;">Modus wählen: gesamtes Lernfeld, einzelne Unit (über Lernfelder-Ansicht) oder Prüfungstrainings.</p>
			<div class="quiz-toolbar">
				<div class="lf-group">
					<label class="lf-label">Lernfeld</label>
					<select id="quiz-lf-select" class="lf-select"></select>
					<div class="lf-actions">
						<button class="button small" id="start-lf">LF-Quiz</button>
						<input type="number" id="lf-num" value="20" min="5" max="60" title="Fragen" class="lf-num" />
					</div>
				</div>
				<div class="quiz-modes">
					<a class="button small" href="#/ap1">AP1-Training</a>
					<a class="button small" href="#/ap2">AP2-Training</a>
				</div>
			</div>
			<div id="quiz-error" style="margin-top:.8rem;color:#f66;font-size:.85rem;"></div>
			<div id="quiz-output" style="margin-top:1.2rem;"></div>
		</div>
	`;
	initHome();

	async function initHome() {
		const sel = outlet.querySelector('#quiz-lf-select');
		const out = outlet.querySelector('#quiz-output');
		const errBox = outlet.querySelector('#quiz-error');
		try {
			const lfs = await getLearningFields();
			sel.innerHTML = lfs.map(l=>`<option value="${l.id}">${l.code} – ${l.title}</option>`).join('');
		} catch(e) {
			sel.innerHTML = '<option>Fehler beim Laden</option>';
			errBox.textContent = 'Lernfelder konnten nicht geladen werden.';
		}
		outlet.querySelector('#start-lf').onclick = async () => {
			const lfId = sel.value; const num = Number(outlet.querySelector('#lf-num').value)||20;
			errBox.textContent='';
			out.innerHTML = '<div class="card">Starte Lernfeld-Quiz...</div>';
			try {
				const quiz = await apiStartQuiz('lf', { scopeRef: Number(lfId), num });
				renderQuiz(out, quiz);
			} catch(err) {
				let msg = err?.message || 'Unbekannter Fehler';
				out.innerHTML = '';
				errBox.textContent = 'Fehler: '+msg;
			}
		};
	}
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
