// Quizzes Route
import express from 'express';
import { z } from 'zod';
import { startQuiz, answerQuestion, finishQuiz } from '../services/quizzes.js';
import { requireAuth, currentUser } from '../utils/auth.js';
import { queryOne } from '../db.js';

const router = express.Router();

// POST /api/quizzes/start
router.post('/quizzes/start', requireAuth, (req, res, next) => {
	try {
		const schema = z.object({
			scope: z.enum(['unit', 'lf', 'ap1', 'ap2']),
			scopeRef: z.any().optional(),
			num: z.number().min(1).max(100).optional(),
			timerSec: z.number().min(10).max(3600).nullable().optional()
		});
		const { scope, scopeRef, num, timerSec } = schema.parse(req.body);
		const user = currentUser(req);
		const quiz = startQuiz(user.id, { scope, scopeRef, num, timerSec });
		res.json(quiz);
	} catch (err) {
		if (err instanceof z.ZodError) {
			return res.status(400).json({ status: 'error', message: 'Ungültige Eingaben', details: err.errors });
		}
		next(err);
	}
});

// POST /api/quizzes/:attemptId/answer
router.post('/quizzes/:attemptId/answer', requireAuth, (req, res, next) => {
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
router.post('/quizzes/:attemptId/finish', requireAuth, (req, res, next) => {
	try {
		const result = finishQuiz(req.params.attemptId);
		res.json(result);
	} catch (err) {
		next(err);
	}
});

// GET /api/attempts/:attemptId/review
router.get('/attempts/:attemptId/review', requireAuth, (req, res, next) => {
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
