// Quizzes Route
import express from 'express';
import { z } from 'zod';
import { startQuiz, answerQuestion, finishQuiz } from '../services/quizzes.js';
import { currentUser } from '../utils/auth.js';
import { queryOne, run } from '../db.js';

const router = express.Router();

// Handler für Quiz-Start (legacy Pfad + neuer Pfad)
function handleStart(req, res, next) {
	try {
		const schema = z.object({
			scope: z.enum(['unit', 'lf', 'ap1', 'ap2']),
			scopeRef: z.any().optional(),
			num: z.number().min(1).max(100).optional(),
			timerSec: z.number().min(10).max(3600).nullable().optional()
		});
		const { scope, scopeRef, num, timerSec } = schema.parse(req.body);
		let user = currentUser(req);
		if (!user) {
			// Gast-User sicherstellen (persistenter Dummy, um NOT NULL einzuhalten)
			let guest = queryOne('SELECT id FROM users WHERE email = ?',[ 'guest@example.com' ]);
			if (!guest) {
				run('INSERT INTO users (email, password_hash, display_name, role, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)', [ 'guest@example.com', 'x', 'Gast', 'learner' ]);
				guest = queryOne('SELECT id FROM users WHERE email = ?',[ 'guest@example.com' ]);
			}
			user = { id: guest.id };
		}
		const quiz = startQuiz(user.id, { scope, scopeRef, num, timerSec });
		res.json(quiz);
	} catch (err) {
		if (err instanceof z.ZodError) {
			return res.status(400).json({ status: 'error', message: 'Ungültige Eingaben', details: err.errors });
		}
		next(err);
	}
}
// Neuer korrekter Pfad
router.post('/start', handleStart);
// Legacy (doppelt /quizzes/start) für evtl. alte Frontends
router.post('/quizzes/start', handleStart);

// POST /api/quizzes/:attemptId/answer (korrekt: /api/quizzes/:attemptId/answer)
router.post('/:attemptId/answer', (req, res, next) => {
	try {
		const schema = z.object({
			question_id: z.number(),
			option_id: z.number()
		});
		const { question_id, option_id } = schema.parse(req.body);
		answerQuestion(req.params.attemptId, question_id, option_id);
		res.json({ status: 'ok' });
	} catch (err) {
		if (err instanceof z.ZodError) {
			return res.status(400).json({ status: 'error', message: 'Ungültige Eingaben', details: err.errors });
		}
		next(err);
	}
});

// POST /api/quizzes/:attemptId/finish
router.post('/:attemptId/finish', (req, res, next) => {
	try {
		const result = finishQuiz(req.params.attemptId);
		res.json(result);
	} catch (err) {
		next(err);
	}
});

// GET /api/quizzes/attempts/:attemptId/review
router.get('/attempts/:attemptId/review', (req, res, next) => {
	try {
		const attempt = queryOne('SELECT * FROM attempts WHERE id = ?', [req.params.attemptId]);
		if (!attempt) return res.status(404).json({ status: 'error', message: 'Attempt nicht gefunden' });
		res.json({
			attempt_id: attempt.id,
			user_id: attempt.user_id,
			started_at: attempt.started_at,
			finished_at: attempt.finished_at,
			score: attempt.score,
			detail: JSON.parse(attempt.detail_json),
			scope: attempt.scope,
			scope_ref: attempt.scope_ref
		});
	} catch (err) {
		next(err);
	}
});

export default router;
