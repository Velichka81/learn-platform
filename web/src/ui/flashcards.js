import { getDueFlashcards, reviewFlashcard, getLearningFields, getLearningFieldFlashcards } from '../api.js';

export function renderFlashcardsPage(outlet) {
	if (!outlet) {
		alert('FEHLER: Outlet-Element für Lernkarten nicht gefunden!');
		return;
	}
	outlet.innerHTML = `
		<div class="card">
			<h2 style="margin-top:0;">Lernkarten</h2>
			<p style="margin:0 0 1rem 0;">Modus wählen: Tages-Wiederholung oder nach Lernfeld gruppiert anzeigen.</p>
			<div class="flashcards-toolbar">
				<button class="button small mode-btn active" id="btn-due">Fällige Karten (Heute)</button>
				<div class="field-group">
					<label for="lf-select">Lernfeld</label>
					<div class="field-inline">
						<select id="lf-select"></select>
						<button class="button small ghost" id="btn-lf-load">Anzeigen</button>
					</div>
				</div>
			</div>
			<div id="fc-mount" class="flashcards-mount"></div>
		</div>
	`;

	init();

	async function init() {
		await populateLFSelect();
		bindEvents();
		// Standard: fällige Karten laden (künftig könnte letzter Modus aus localStorage gelesen werden)
		loadDue();
	}

	async function populateLFSelect() {
		const sel = outlet.querySelector('#lf-select');
		if (!sel) return;
		try {
			const lfs = await getLearningFields();
			sel.innerHTML = lfs.map(l => `<option value="${l.id}">${l.code} – ${l.title}</option>`).join('');
		} catch(e) {
			sel.innerHTML = '<option>Error beim Laden</option>';
		}
	}

	function bindEvents() {
		outlet.querySelector('#btn-due')?.addEventListener('click', () => loadDue());
		outlet.querySelector('#btn-lf-load')?.addEventListener('click', () => {
			const lfId = outlet.querySelector('#lf-select')?.value;
			if (lfId) loadLF(lfId);
		});
		// NEU: automatisch beim Wechsel des Lernfeldes laden (ohne extra Klick auf "Anzeigen")
		const sel = outlet.querySelector('#lf-select');
		if (sel) {
			sel.addEventListener('change', () => {
				const lfId = sel.value;
				if (lfId) loadLF(lfId);
			});
		}
	}

	async function loadLF(lfId) {
		markMode('lf');
		const mount = outlet.querySelector('#fc-mount');
		if (!mount) return;
		const sel = outlet.querySelector('#lf-select');
		const lfDisplay = sel ? sel.options[sel.selectedIndex].text : `Lernfeld ${lfId}`;
		mount.innerHTML = 'Lade Lernfeld-Karten…';
		try {
			const grouped = await getLearningFieldFlashcards(lfId);
			if (!grouped.length) { mount.innerHTML = '<em>Keine Karten für dieses Lernfeld.</em>'; return; }
			// Alle Karten in ein Deck flatten (Reihenfolge: nach Units, dann ID)
			const deck = [];
			grouped.forEach(g => g.flashcards.forEach(fc => deck.push(fc)));
			const originalOrder = deck.map(c => c); // Kopie merken
			mount.innerHTML = `<div class="lf-active-bar" style="margin-bottom:12px;"><div class="lf-active-name">${escapeHTML(lfDisplay)}</div><div style="margin-left:auto; display:flex; gap:6px;"><button class="button button--ghost small" id="deck-shuffle">Mischen</button><button class="button button--ghost small" id="deck-restart" disabled>Neu starten</button></div></div><div id="lf-deck"></div>`;
			const deckMount = mount.querySelector('#lf-deck');
			// Nutzung vorhandener FlashcardViewer-Komponente
			FlashcardViewer(deckMount, deck, { async onReview(id, result){ try { await reviewFlashcard({ flashcard_id:id, result }); } catch(e){} } });
			// Zusatz-Controls
			const shuffleBtn = mount.querySelector('#deck-shuffle');
			const restartBtn = mount.querySelector('#deck-restart');
			if (shuffleBtn) {
				shuffleBtn.addEventListener('click', () => {
					for (let i=deck.length-1;i>0;i--) { const j=Math.floor(Math.random()*(i+1)); [deck[i],deck[j]]=[deck[j],deck[i]]; }
					deckMount.innerHTML = '';
					FlashcardViewer(deckMount, deck, { async onReview(id, result){ try { await reviewFlashcard({ flashcard_id:id, result }); } catch(e){} } });
					restartBtn.disabled = false;
				});
			}
			if (restartBtn) {
				restartBtn.addEventListener('click', () => {
					// ursprüngliche Reihenfolge wieder herstellen
					deck.splice(0, deck.length, ...originalOrder.map(c => c));
					deckMount.innerHTML = '';
					FlashcardViewer(deckMount, deck, { async onReview(id, result){ try { await reviewFlashcard({ flashcard_id:id, result }); } catch(e){} } });
					restartBtn.disabled = true;
				});
			}
		} catch(e) { mount.innerHTML = '<em>Fehler beim Laden: '+ (e.message || e) +'</em>'; }
	}

	function markMode(mode) {
		const dueBtn = outlet.querySelector('#btn-due');
		if (dueBtn) dueBtn.classList.toggle('active', mode === 'due');
		const lfBtn = outlet.querySelector('#btn-lf-load');
		if (lfBtn) lfBtn.classList.toggle('active', mode === 'lf');
	}
	async function loadDue() { markMode('due'); load(); }
	async function load() {
		const mount = outlet.querySelector('#fc-mount');
		if (!mount) {
			outlet.innerHTML += '<div style="color:red">FEHLER: #fc-mount nicht gefunden!</div>';
			return;
		}
		mount.innerHTML = 'Lade fällige Karten…';
		try {
			const cards = await getDueFlashcards();
			if (!cards.length) { mount.innerHTML = '<em>Heute sind keine Karten fällig.</em>'; return; }
			mount.innerHTML = '';
			FlashcardViewer(mount, cards, { async onReview(id, result) { try { await reviewFlashcard({ flashcard_id: id, result }); } catch(e){ console.error(e); } } });
		} catch(e) { mount.innerHTML = '<em>Fehler beim Laden der Karten: ' + (e.message || e) + '</em>'; }
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

function escapeHTML(str) {
	return str.replace(/[&<>"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
}
function escapeAttr(str) {
	return escapeHTML(str).replace(/"/g, '&quot;');
}
function filterCards(term, mount) {
	term = term.trim().toLowerCase();
	const groups = mount.querySelectorAll('.fc-group');
	let visibleCount = 0;
	groups.forEach(g => {
		let groupVisible = false;
		g.querySelectorAll('li').forEach(li => {
			const q = li.getAttribute('data-q')?.toLowerCase() || '';
			const a = li.getAttribute('data-a')?.toLowerCase() || '';
			const match = !term || q.includes(term) || a.includes(term);
			li.style.display = match ? '' : 'none';
			if (match) groupVisible = true;
		});
		g.style.display = groupVisible ? '' : 'none';
		if (groupVisible) visibleCount++;
	});
	const bar = mount.querySelector('.lf-active-name');
	if (bar) {
		bar.dataset.filtered = term ? 'true' : 'false';
	}
}

// Fügt einmalig CSS für Flip/Reveal hinzu
let revealCssAdded = false;
function injectRevealStyles() {
	if (revealCssAdded) return;
	const style = document.createElement('style');
	style.textContent = `
		.fc-list { list-style:none; margin:0; padding:0; display:flex; flex-direction:column; gap:6px; }
		.fc-item { background:#251437; border:1px solid #3c235a; padding:10px 12px; border-radius:6px; cursor:pointer; position:relative; transition:background .2s; }
		.fc-item:hover { background:#2e1b48; }
		.fc-item.revealed { background:#2f2544; }
		.fc-item .a { margin-top:6px; color:#d9c9ff; }
		.fc-item .q { font-weight:600; }
		.fc-item:focus-visible { outline:2px solid #8257e6; outline-offset:2px; }
		.lf-mode-switch { display:flex; gap:4px; margin-left:12px; }
		.lf-groups[data-view="einzel"] { display:none; }
	`;
	document.head.appendChild(style);
	revealCssAdded = true;
}

// (Alter Listen-/Einzelmodus entfernt – jetzt nur Deck-Viewer)
