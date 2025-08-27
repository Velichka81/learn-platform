// Flashcards Service
import { queryOne, run } from '../db.js';

export function leitnerNextDate(box) {
	const intervals = [1, 3, 7, 14, 30];
	const days = intervals[Math.max(0, Math.min(box - 1, intervals.length - 1))];
	const date = new Date();
	date.setDate(date.getDate() + days);
	return date.toISOString().slice(0, 10);
}

export function reviewCard(userId, flashcardId, result) {
	const row = queryOne('SELECT box FROM flashcard_progress WHERE user_id = ? AND flashcard_id = ?', [userId, flashcardId]);
	let box = row ? row.box : 1;
	if (result === 'correct') box = Math.min(box + 1, 5);
	else if (result === 'wrong') box = 1;
	// 'unsure' → box bleibt
	const next_due = leitnerNextDate(box);
	run(`INSERT INTO flashcard_progress (user_id, flashcard_id, box, next_due, last_result)
				VALUES (?, ?, ?, ?, ?)
				ON CONFLICT(user_id, flashcard_id) DO UPDATE SET box=excluded.box, next_due=excluded.next_due, last_result=excluded.last_result`,
			[userId, flashcardId, box, next_due, result]);
	return { box, next_due };
}
