// Quizzes Service
import { queryAll, queryOne, run } from '../db.js';

function shuffle(arr) {
	return arr.map(v => [Math.random(), v]).sort((a, b) => a[0] - b[0]).map(x => x[1]);
}

export function buildQuestionPool(scope, scopeRef) {
	let questions = [];
	if (scope === 'unit') {
		questions = queryAll('SELECT * FROM questions WHERE unit_id = ?', [scopeRef]);
	} else if (scope === 'lf') {
		questions = queryAll('SELECT q.* FROM questions q JOIN units u ON q.unit_id = u.id WHERE u.topic_id IN (SELECT t.id FROM topics t JOIN chapters c ON t.chapter_id = c.id WHERE c.learning_field_id = ?) ', [scopeRef]);
	} else if (scope === 'ap1' || scope === 'ap2') {
		questions = queryAll(`SELECT q.* FROM questions q JOIN units u ON q.unit_id = u.id JOIN topics t ON u.topic_id = t.id JOIN chapters c ON t.chapter_id = c.id JOIN learning_fields lf ON c.learning_field_id = lf.id WHERE lf.exam_phase = ?`, [scope.toUpperCase()]);
	}
	return shuffle(questions);
}

export function startQuiz(userId, { scope, scopeRef, num = 20, timerSec = null }) {
	const pool = buildQuestionPool(scope, scopeRef);
	const selected = pool.slice(0, num);
	const questionIds = selected.map(q => q.id);
	const detail = { questionIds, answers: {} };
	const result = run(
		'INSERT INTO attempts (quiz_id, user_id, started_at, score, detail_json, scope, scope_ref) VALUES (?, ?, datetime("now"), NULL, ?, ?, ?)',
		[null, userId, JSON.stringify(detail), scope, scopeRef || null]
	);
	const attempt_id = result.lastInsertRowid;
	const questions = selected.map(q => {
		const opts = queryAll('SELECT id, label FROM options WHERE question_id = ?', [q.id]);
		return { id: q.id, stem: q.stem, type: q.type, options: opts };
	});
	return { attempt_id, questions, timerSec };
}

export function answerQuestion(attemptId, questionId, optionId) {
	const attempt = queryOne('SELECT detail_json FROM attempts WHERE id = ?', [attemptId]);
	if (!attempt) throw new Error('Attempt nicht gefunden');
	const detail = JSON.parse(attempt.detail_json);
	if (!detail.answers) detail.answers = {};
	if (!detail.answers[questionId]) detail.answers[questionId] = [];
	if (!detail.answers[questionId].includes(optionId)) detail.answers[questionId].push(optionId);
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
			if (userAns.length === 1 && correctOpt && userAns[0] === correctOpt.id) correct++;
			else errors.push({ qid, explanation: q.explanation });
		} else if (q.type === 'mc') {
			const correctIds = opts.filter(o => o.is_correct).map(o => o.id).sort();
			const userIds = [...userAns].sort();
			if (JSON.stringify(correctIds) === JSON.stringify(userIds)) correct++;
			else errors.push({ qid, explanation: q.explanation });
		}
	}
	const score = total ? correct / total : 0;
	run('UPDATE attempts SET finished_at = datetime("now"), score = ?, detail_json = ? WHERE id = ?', [score, JSON.stringify(detail), attemptId]);
	return { score, errors };
}
