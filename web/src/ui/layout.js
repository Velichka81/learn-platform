// Layout-Komponente
export function renderLayout(root, renderContent) {
	root.innerHTML = `
		<div class="layout">
			<aside class="sidebar">
				<button class="sidebar__close" id="sidebar-close" aria-label="Schließen">&lt;</button>
				<div class="sidebar__logo"><strong>Learn</strong>Platform</div>
				<nav class="sidebar__nav">
					<a href="#/dashboard" class="nav__link" data-link="dashboard">Dashboard</a>
					<a href="#/learning" class="nav__link" data-link="learning">Lernfelder</a>
					<a href="#/flashcards" class="nav__link" data-link="flashcards">Lernkarten</a>
					<a href="#/quiz" class="nav__link" data-link="quiz">Quiz</a>
					<a href="#/ap1" class="nav__link" data-link="ap1">AP1</a>
					<a href="#/ap2" class="nav__link" data-link="ap2">AP2</a>
					<a href="#/profile" class="nav__link" data-link="profile">Profil</a>
				</nav>
			</aside>
			<main class="main">
				<header class="topbar">
					<button class="hamburger" id="menu-toggle" aria-label="Menü" aria-expanded="false">☰</button>
					<input class="topbar__search" placeholder="Suche..." />
					<button class="button button--ghost" id="theme-toggle">Theme</button>
					<div class="topbar__user">👤</div>
				</header>
				<section class="content" data-outlet></section>
			</main>
		</div>
	`;

	const html = document.documentElement;
	const btn = document.getElementById('theme-toggle');
	const menuBtn = document.getElementById('menu-toggle');
	const sidebar = root.querySelector('.sidebar');
	const closeBtn = root.querySelector('#sidebar-close');
	if (menuBtn) {
		menuBtn.addEventListener('click', () => {
			const open = sidebar.classList.toggle('sidebar--open');
			menuBtn.setAttribute('aria-expanded', open ? 'true':'false');
		});
	}
	if (closeBtn) {
		closeBtn.addEventListener('click', () => {
			sidebar.classList.remove('sidebar--open');
			menuBtn?.setAttribute('aria-expanded','false');
		});
	}
	btn.addEventListener('click', () => {
		const next = html.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
		html.setAttribute('data-theme', next);
		localStorage.setItem('theme', next);
	});

	if (typeof renderContent === 'function') renderContent();
}

export function setActiveLink(key) {
	document.querySelectorAll('.nav__link').forEach(a => {
		a.classList.toggle('active', a.dataset.link === key);
	});
}
