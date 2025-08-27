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
