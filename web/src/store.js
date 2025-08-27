// Einfacher globaler State mit Subscribe
const state = {
	user: null,
	csrf: null,
	route: window.location.hash.slice(1) || '/dashboard',
};

const listeners = [];

export function getState() {
	return { ...state };
}

export function setState(patch) {
	Object.assign(state, patch);
	listeners.forEach(fn => fn(getState()));
}

export function subscribe(fn) {
	listeners.push(fn);
	return () => {
		const i = listeners.indexOf(fn);
		if (i >= 0) listeners.splice(i, 1);
	};
}

window.addEventListener('hashchange', () => {
	setState({ route: window.location.hash.slice(1) || '/dashboard' });
});
