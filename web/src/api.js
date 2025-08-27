export async function getDueFlashcards() {
	return fetchJSON('GET', '/api/flashcards/due/today');
}
// API-Wrapper
const BASE = import.meta.env.VITE_API_URL || 'http://localhost:8080';
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
	if (!res.ok) throw await res.json();
	return res.json();
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
	return fetchJSON('GET', `/api/chapters/${chapterId}/topics`);
}
export async function getUnit(id) {
	return fetchJSON('GET', `/api/units/${id}`);
}
export async function getUnitFlashcards(id) {
	return fetchJSON('GET', `/api/units/${id}/flashcards`);
}
export async function reviewFlashcard(payload) {
	return fetchJSON('POST', '/api/flashcards/review', payload);
}
export async function startQuiz(scope, opts) {
	return fetchJSON('POST', '/api/quizzes/start', { scope, ...opts });
}
export async function answer(attemptId, question_id, option_id) {
	return fetchJSON('POST', `/api/quizzes/${attemptId}/answer`, { question_id, option_id });
}
export async function finish(attemptId) {
	return fetchJSON('POST', `/api/quizzes/${attemptId}/finish`);
}
export async function getReview(attemptId) {
	return fetchJSON('GET', `/api/attempts/${attemptId}/review`);
}
