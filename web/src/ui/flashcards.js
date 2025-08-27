import { getDueFlashcards, reviewFlashcard } from '../api.js';

export function renderFlashcardsPage(outlet) {
	if (!outlet) {
		alert('FEHLER: Outlet-Element für Lernkarten nicht gefunden!');
		return;
	}
	outlet.innerHTML = `
		<div class="card">
			<h2>Lernkarten</h2>
			<p>Hier startest du deine heutige Wiederholung (Leitner).</p>
			<div id="fc-mount" style="margin-top:12px;"></div>
		</div>
	`;
	load();
	async function load() {
		const mount = outlet.querySelector('#fc-mount');
		if (!mount) {
			outlet.innerHTML += '<div style="color:red">FEHLER: #fc-mount nicht gefunden!</div>';
			return;
		}
		mount.innerHTML = 'Lade fällige Karten…';
		try {
			const cards = await getDueFlashcards();
			console.log('API getDueFlashcards result:', cards);
			if (!cards.length) {
				mount.innerHTML = '<em>Heute sind keine Karten fällig. Öffne eine Unit oder füge Karten per Seed hinzu.</em>';
				return;
			}
			mount.innerHTML = '';
			console.log('Starte FlashcardViewer mit', cards.length, 'Karten');
			FlashcardViewer(mount, cards, {
				async onReview(id, result) {
					try { await reviewFlashcard({ flashcard_id: id, result }); } catch(e){ console.error(e); }
				}
			});
		} catch(e) {
			mount.innerHTML = '<em>Fehler beim Laden der Karten: ' + (e.message || e) + '</em>';
			console.error('Fehler beim Laden der Karten:', e);
		}
	}
}

// einfacher Viewer (falls noch nicht vorhanden)
export function FlashcardViewer(mount, cards, { onReview } = {}) {
	let idx = 0, flipped = false;
	const wrapper = document.createElement('div');
	wrapper.innerHTML = `
		<div class="card" id="fc" style="min-height:160px; display:grid; place-items:center; font-size:18px; cursor:pointer; margin-bottom:12px;">
			<div id="front"></div>
			<div id="back" style="display:none;"></div>
		</div>
		<div style="display:flex; gap:8px;">
			<button class="button" data-r="correct">Gewusst (1)</button>
			<button class="button button--ghost" data-r="unsure">Unsicher (2)</button>
			<button class="button button--ghost" data-r="wrong">Falsch (3)</button>
		</div>
		<div style="margin-top:8px;"><small id="progress"></small></div>
	`;
	mount.appendChild(wrapper);

	const front = wrapper.querySelector('#front');
	const back  = wrapper.querySelector('#back');
	const cardEl = wrapper.querySelector('#fc');
	const progress = wrapper.querySelector('#progress');

	function update() {
		const c = cards[idx];
		flipped = false;
		front.style.display = '';
		back.style.display  = 'none';
		front.textContent = c.question;
		back.textContent  = c.answer;
		progress.textContent = `Karte ${idx+1} von ${cards.length}`;
	}

	cardEl.addEventListener('click', () => {
		flipped = !flipped;
		front.style.display = flipped ? 'none' : '';
		back.style.display  = flipped ? '' : 'none';
	});

	wrapper.querySelectorAll('[data-r]').forEach(btn => {
		btn.addEventListener('click', async () => {
			if (typeof onReview === 'function') {
				await onReview(cards[idx].id, btn.dataset.r);
			}
			idx++;
			if (idx >= cards.length) {
				mount.innerHTML = `<div class="card"><h3>Session beendet</h3><p>Super! Du hast alle fälligen Karten durch.</p></div>`;
			} else {
				update();
			}
		});
	});

	window.addEventListener('keydown', (e) => {
		if (e.key === '1') wrapper.querySelector('[data-r="correct"]').click();
		if (e.key === '2') wrapper.querySelector('[data-r="unsure"]').click();
		if (e.key === '3') wrapper.querySelector('[data-r="wrong"]').click();
		if (e.key === ' ') cardEl.click();
	});

	update();
}
