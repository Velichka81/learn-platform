import { getUnit, getUnitFlashcards, reviewFlashcard, startQuiz } from '../api.js';

function sanitizeHTML(html) {
	// Erlaubt nur wenige Tags
	return html.replace(/<(?!\/?(b|i|u|em|strong|ul|ol|li|p|br|h[1-4]))[^>]*>/gi, '');
}

export async function renderUnit(root, unitId) {
	root.innerHTML = '<div class="card">Lade...</div>';
	const unit = await getUnit(unitId);
	let tab = 'theorie';
	let flashcards = null;
	let quizResult = null;

	function render() {
		root.innerHTML = `
			<div class="tabs">
				<button class="${tab==='theorie'?'active':''}" data-tab="theorie">Theorie</button>
				<button class="${tab==='karten'?'active':''}" data-tab="karten">Lernkarten</button>
				<button class="${tab==='quiz'?'active':''}" data-tab="quiz">Quiz</button>
				<button class="${tab==='notizen'?'active':''}" data-tab="notizen">Notizen</button>
			</div>
			<div id="unit-tab-content"></div>
		`;
		root.querySelectorAll('.tabs button').forEach(btn => {
			btn.onclick = () => { tab = btn.dataset.tab; render(); };
		});
		const content = root.querySelector('#unit-tab-content');
		if (tab === 'theorie') {
			content.innerHTML = `<div class="card"><h2>${unit.title}</h2><div>${sanitizeHTML(unit.summary||'')}</div></div>`;
		} else if (tab === 'karten') {
			if (!flashcards) {
				content.innerHTML = '<div class="card">Lade Karten...</div>';
				getUnitFlashcards(unitId).then(cards => {
					flashcards = cards;
					render();
				});
				return;
			}
			import('./flashcards.js').then(mod => {
				content.innerHTML = '';
				mod.FlashcardViewer({ cards: flashcards, onReview: async (result, cardId) => {
					await reviewFlashcard({ flashcard_id: cardId, result });
				}, mount: content });
			});
		} else if (tab === 'quiz') {
			if (!quizResult) {
				content.innerHTML = `<div class="card" style="text-align:center;"><button class="button" id="start-quiz">Unit-Quiz starten</button></div>`;
				content.querySelector('#start-quiz').onclick = async () => {
					const quiz = await startQuiz('unit', { scopeRef: unitId });
					import('./quiz.js').then(mod => {
						mod.renderQuiz(content, quiz);
					});
				};
			} else {
				content.innerHTML = quizResult;
			}
		} else if (tab === 'notizen') {
			const key = `unit-note-${unitId}`;
			const val = localStorage.getItem(key) || '';
			content.innerHTML = `<div class="card"><textarea style="width:100%;min-height:180px;">${val}</textarea></div>`;
			const ta = content.querySelector('textarea');
			ta.oninput = () => localStorage.setItem(key, ta.value);
		}
	}
	render();
}
