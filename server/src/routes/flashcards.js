// Flashcards Route
import express from 'express';
import { queryAll } from '../db.js';
import { reviewCard } from '../services/flashcards.js';
import { requireAuth, currentUser } from '../utils/auth.js';

const router = express.Router();

// GET /api/units/:id/flashcards
router.get('/units/:id/flashcards', (req, res) => {
	const cards = queryAll('SELECT id, question, answer, difficulty FROM flashcards WHERE unit_id = ?', [req.params.id]);
	res.json(cards);
});

// GET /api/flashcards/learning-field/:lfId
// Liefert Flashcards eines Lernfelds, gruppiert nach Units (sortiert nach Unit-ID, dann Flashcard-ID)
router.get('/learning-field/:lfId', (req, res, next) => {
	try {
		const rows = queryAll(`
			SELECT 
				u.id AS unit_id,
				u.title AS unit_title,
				f.id AS flashcard_id,
				f.question,
				f.answer,
				f.difficulty
			FROM flashcards f
			JOIN units u ON u.id = f.unit_id
			JOIN topics t ON t.id = u.topic_id
			JOIN chapters c ON c.id = t.chapter_id
			JOIN learning_fields lf ON lf.id = c.learning_field_id
			WHERE lf.id = ?
			ORDER BY u.id, f.id
		`, [req.params.lfId]);
		const grouped = [];
		let current = null;
		for (const r of rows) {
			if (!current || current.unit_id !== r.unit_id) {
				current = { unit_id: r.unit_id, unit_title: r.unit_title, flashcards: [] };
				grouped.push(current);
			}
			current.flashcards.push({ id: r.flashcard_id, question: r.question, answer: r.answer, difficulty: r.difficulty });
		}
		res.json(grouped);
	} catch (e) { next(e); }
});

// POST /api/flashcards/review
router.post('/flashcards/review', requireAuth, (req, res) => {
	const user = currentUser(req);
	const { flashcard_id, result } = req.body;
	if (!['correct', 'wrong', 'unsure'].includes(result)) {
		return res.status(400).json({ status: 'error', message: 'Ungültiges Ergebnis' });
	}
	const r = reviewCard(user.id, flashcard_id, result);
	res.json(r);
});

// GET /api/flashcards/due/today
router.get('/due/today', async (req, res, next) => {
	try {
		// const userId = req.session?.user?.id || 0;
		const userId = 0; // bis Auth fertig ist
		const sql = `
			SELECT f.id, f.unit_id, f.question, f.answer, f.difficulty
			FROM flashcards f
			LEFT JOIN flashcard_progress p 
				ON p.flashcard_id = f.id AND p.user_id = ?
			WHERE p.flashcard_id IS NULL
				 OR DATE(p.next_due) <= DATE('now')
			ORDER BY f.id
			LIMIT 20;
		`;
		const rows = queryAll(sql, [userId]);
		res.json(rows);
	} catch (e) { next(e); }
});

export default router;
