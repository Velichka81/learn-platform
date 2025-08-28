export async function getDueFlashcards() {
	return fetchJSON('GET', '/api/flashcards/due/today');
}
// API-Wrapper
// Frontend läuft auf 5173; bei relativen /api/ nutzt Vite Proxy -> Backend 8090
const BASE = import.meta.env.VITE_API_URL || '';
let csrf = null;

async function fetchJSON(method, path, body) {
	const headers = { 'Content-Type': 'application/json' };
	if (csrf) headers['x-csrf-token'] = csrf;
	// Wenn der Pfad mit /api/ beginnt, direkt verwenden (Vite-Proxy)
	const url = path.startsWith('/api/') ? path : BASE + path;
	const res = await fetch(url, {
		method,
		credentials: 'include',
		headers,
		body: body ? JSON.stringify(body) : undefined,
	});
	const ct = res.headers.get('Content-Type') || '';
	if (!res.ok) {
		if (ct.includes('application/json')) {
			throw await res.json();
		} else {
			const text = await res.text();
			throw { status: 'error', message: text.startsWith('<') ? 'Serverfehler oder nicht angemeldet.' : text };
		}
	}
	if (ct.includes('application/json')) return res.json();
	// Fallback falls der Server unerwartet kein JSON sendet
	return {};
}

export async function getMe() {
	const data = await fetchJSON('GET', '/api/auth/me');
	csrf = data.csrf;
	return data;
}
export async function register(payload) {
	return fetchJSON('POST', '/api/auth/register', payload);
}
export async function login(payload) {
	return fetchJSON('POST', '/api/auth/login', payload);
}
export async function logout(payload) {
	return fetchJSON('POST', '/api/auth/logout', payload);
}
export async function getLearningFields() {
	return fetchJSON('GET', '/api/learning-fields');
}
export async function getChapters(lfId) {
	return fetchJSON('GET', `/api/learning-fields/${lfId}/chapters`);
}
export async function getTopics(chapterId) {
	// Server-Routen liegen (nach Reset) unter /api/learning-fields/chapters/:id/topics
	return fetchJSON('GET', `/api/learning-fields/chapters/${chapterId}/topics`);
}
export async function getUnit(id) {
	return fetchJSON('GET', `/api/units/${id}`);
}
export async function getUnitFlashcards(id) {
	return fetchJSON('GET', `/api/units/${id}/flashcards`);
}
export async function getLearningFieldFlashcards(lfId) {
	return fetchJSON('GET', `/api/flashcards/learning-field/${lfId}`);
}
export async function reviewFlashcard(payload) {
	return fetchJSON('POST', '/api/flashcards/review', payload);
}
export async function startQuiz(scope, opts) {
	return fetchJSON('POST', '/api/quizzes/start', { scope, ...opts }); // bleibt kompatibel (Backend hat Legacy-Mapping)
}
export async function answer(attemptId, question_id, option_id) {
	return fetchJSON('POST', `/api/quizzes/${attemptId}/answer`, { question_id, option_id });
}
export async function finish(attemptId) {
	return fetchJSON('POST', `/api/quizzes/${attemptId}/finish`);
}
export async function getReview(attemptId) {
	return fetchJSON('GET', `/api/quizzes/attempts/${attemptId}/review`);
}
