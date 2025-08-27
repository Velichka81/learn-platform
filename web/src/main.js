import { renderLayout, setActiveLink } from './ui/layout.js';
import { renderDashboard } from './ui/dashboard.js';
import { renderLearning } from './ui/learning.js';
import { renderFlashcardsPage } from './ui/flashcards.js';
import { renderQuizHome, renderApMode } from './ui/quiz.js';
import { renderUnit } from './ui/unit.js';

function parseHash() {
	const hash = location.hash || '#/dashboard';
	const [_, path, param] = hash.match(/^#\/([^/]+)\/?([^/]*)/) || [];
	return { path: path || 'dashboard', param: param || null };
}


function renderRoute() {
	const root = document.getElementById('app');
	const { path, param } = parseHash();

	// Grundlayout rendern
	renderLayout(root, () => {
		// Warten, bis das Layout im DOM ist
		requestAnimationFrame(() => {
			const outlet = document.querySelector('[data-outlet]');
			switch (path) {
				case 'dashboard':
					renderDashboard(outlet);
					break;
				case 'learning':
					renderLearning(outlet);
					break;
				case 'unit':
					renderUnit(outlet, param);
					break;
				case 'flashcards':
					renderFlashcardsPage(outlet);
					break;
				case 'quiz':
					renderQuizHome(outlet);
					break;
				case 'ap1':
					renderApMode(outlet, 'ap1');
					break;
				case 'ap2':
					renderApMode(outlet, 'ap2');
					break;
				default:
					renderDashboard(outlet);
			}
			// aktiven Link markieren
			const activeKey = (path === 'unit') ? 'learning' : path;
			setActiveLink(activeKey);
		});
	});
}

// Theme init
(function initTheme(){
	const saved = localStorage.getItem('theme');
	const html = document.documentElement;
	if (saved === 'light' || saved === 'dark') {
		html.setAttribute('data-theme', saved);
	}
})();

window.addEventListener('hashchange', renderRoute);
window.addEventListener('DOMContentLoaded', renderRoute);
