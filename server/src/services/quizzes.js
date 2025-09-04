// Quizzes Service
import { queryAll, queryOne, run } from '../db.js';

function shuffle(arr) {
	return arr.map(v => [Math.random(), v]).sort((a, b) => a[0] - b[0]).map(x => x[1]);
}

export function buildQuestionPool(scope, scopeRef) {
	let questions = [];
	if (scope === 'unit') {
		questions = queryAll("SELECT * FROM questions WHERE unit_id = ? AND type != 'gap'", [scopeRef]);
	} else if (scope === 'lf') {
		questions = queryAll("SELECT q.* FROM questions q JOIN units u ON q.unit_id = u.id WHERE q.type != 'gap' AND u.topic_id IN (SELECT t.id FROM topics t JOIN chapters c ON t.chapter_id = c.id WHERE c.learning_field_id = ?)", [scopeRef]);
	} else if (scope === 'ap1' || scope === 'ap2') {
		questions = queryAll(`SELECT q.* FROM questions q JOIN units u ON q.unit_id = u.id JOIN topics t ON u.topic_id = t.id JOIN chapters c ON t.chapter_id = c.id JOIN learning_fields lf ON c.learning_field_id = lf.id WHERE q.type != 'gap' AND lf.exam_phase = ?`, [scope.toUpperCase()]);
	}
	return shuffle(questions);
}

export function startQuiz(userId, { scope, scopeRef, num = 20, timerSec = null }) {
	const pool = buildQuestionPool(scope, scopeRef);
	const selected = pool.slice(0, num);
	const questionIds = selected.map(q => q.id);
	const detail = { questionIds, answers: {} };
	const uid = userId || null; // Gäste = null
	const result = run(
		'INSERT INTO attempts (quiz_id, user_id, started_at, score, detail_json, scope, scope_ref) VALUES (?, ?, CURRENT_TIMESTAMP, NULL, ?, ?, ?)',
		[null, uid, JSON.stringify(detail), scope, scopeRef || null]
	);
	const attempt_id = result.lastInsertRowid;
	const questions = selected.map(q => {
		// Include correctness flag for immediate feedback UI (client-side should avoid exposing directly if hiding answers is desired)
		let opts = queryAll('SELECT id, label, is_correct FROM options WHERE question_id = ?', [q.id]);
		// Optionen zufällig mischen, damit richtige Antwort Position wechselt
		opts = shuffle(opts);
		return { id: q.id, stem: q.stem, type: q.type, options: opts };
	});
	return { attempt_id, questions, timerSec };
}

export function answerQuestion(attemptId, questionId, optionId) {
	const attempt = queryOne('SELECT detail_json FROM attempts WHERE id = ?', [attemptId]);
	if (!attempt) throw new Error('Attempt nicht gefunden');
	const detail = JSON.parse(attempt.detail_json);
	if (!detail.answers) detail.answers = {};
	// Ermitteln Fragetyp für korrektes Speichern
	const q = queryOne('SELECT type FROM questions WHERE id = ?', [questionId]);
	if (!q) throw new Error('Frage nicht gefunden');
	if (q.type === 'sc' || q.type === 'tf') {
		// Einzelwahl: immer letzte Auswahl überschreiben
		detail.answers[questionId] = [optionId];
	} else {
		if (!detail.answers[questionId]) detail.answers[questionId] = [];
		if (!detail.answers[questionId].includes(optionId)) detail.answers[questionId].push(optionId);
	}
	run('UPDATE attempts SET detail_json = ? WHERE id = ?', [JSON.stringify(detail), attemptId]);
}

export function finishQuiz(attemptId) {
	const attempt = queryOne('SELECT detail_json FROM attempts WHERE id = ?', [attemptId]);
	if (!attempt) throw new Error('Attempt nicht gefunden');
	const detail = JSON.parse(attempt.detail_json);
	let correct = 0, total = 0, errors = [];
	for (const qid of detail.questionIds) {
		const q = queryOne('SELECT * FROM questions WHERE id = ?', [qid]);
		const opts = queryAll('SELECT id, is_correct FROM options WHERE question_id = ?', [qid]);
		const userAns = (detail.answers && detail.answers[qid]) || [];
		total++;
		if (q.type === 'sc' || q.type === 'tf') {
			const correctOpt = opts.find(o => o.is_correct);
			// Wertung auf Basis letzter Auswahl (falls historische Mehrfachwerte existieren)
			const last = userAns[userAns.length - 1];
			if (last && correctOpt && last === correctOpt.id) correct++; else errors.push({ qid, explanation: q.explanation });
		} else if (q.type === 'mc') {
			const correctIds = opts.filter(o => o.is_correct).map(o => o.id).sort();
			const userIds = [...userAns].sort();
			if (JSON.stringify(correctIds) === JSON.stringify(userIds)) correct++;
			else errors.push({ qid, explanation: q.explanation });
		}
	}
	const score = total ? correct / total : 0;
	run('UPDATE attempts SET finished_at = CURRENT_TIMESTAMP, score = ?, detail_json = ? WHERE id = ?', [score, JSON.stringify(detail), attemptId]);
	return { score, errors };
}
