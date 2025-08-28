import express from 'express';
import { queryAll, queryOne, run } from '../db.js';
import { requireRole } from '../utils/auth.js';

const router = express.Router();

// GET /api/learning-fields
router.get('/', (req, res, next) => {
  try {
    const fields = queryAll('SELECT id, code, title, exam_phase, position FROM learning_fields ORDER BY position');
    res.json(fields);
  } catch (err) {
    next(err);
  }
});

// GET /api/learning-fields/:id/chapters
router.get('/:id/chapters', (req, res, next) => {
  try {
    const lf = queryOne('SELECT id FROM learning_fields WHERE id = ?', [req.params.id]);
    if (!lf) return res.status(404).json({ status: 'error', message: 'Lernfeld nicht gefunden' });
    const chapters = queryAll('SELECT id, title, position FROM chapters WHERE learning_field_id = ? ORDER BY position', [req.params.id]);
    res.json(chapters);
  } catch (err) {
    next(err);
  }
});

// GET /api/chapters/:id/topics
router.get('/chapters/:id/topics', (req, res, next) => {
  try {
    const chapter = queryOne('SELECT id FROM chapters WHERE id = ?', [req.params.id]);
    if (!chapter) return res.status(404).json({ status: 'error', message: 'Kapitel nicht gefunden' });
    const topics = queryAll('SELECT id, title, position FROM topics WHERE chapter_id = ? ORDER BY position', [req.params.id]);
    res.json(topics);
  } catch (err) {
    next(err);
  }
});

// GET /api/topics/:id/units
router.get('/topics/:id/units', (req, res, next) => {
  try {
    const topic = queryOne('SELECT id FROM topics WHERE id = ?', [req.params.id]);
    if (!topic) return res.status(404).json({ status: 'error', message: 'Thema nicht gefunden' });
    const units = queryAll('SELECT id, title FROM units WHERE topic_id = ? ORDER BY id', [req.params.id]);
    res.json(units);
  } catch (err) {
    next(err);
  }
});


// PATCH /api/units/:id
router.patch('/units/:id', requireRole('admin', 'author'), (req, res, next) => {
	try {
		const { title, summary, content_html } = req.body;
		if (!title && !summary && !content_html) {
			return res.status(400).json({ status: 'error', message: 'Mindestens ein Feld muss angegeben werden' });
		}
		const unit = queryOne('SELECT * FROM units WHERE id = ?', [req.params.id]);
		if (!unit) return res.status(404).json({ status: 'error', message: 'Unit nicht gefunden' });
		const fields = [];
		const values = [];
		if (title) { fields.push('title = ?'); values.push(title); }
		if (summary) { fields.push('summary = ?'); values.push(summary); }
		if (content_html) { fields.push('content_html = ?'); values.push(content_html); }
		values.push(req.params.id);
		run(`UPDATE units SET ${fields.join(', ')} WHERE id = ?`, values);
		const updated = queryOne('SELECT id, title, summary, content_html FROM units WHERE id = ?', [req.params.id]);
		res.json(updated);
	} catch (err) {
		next(err);
	}
});

// DELETE /api/units/:id
router.delete('/units/:id', requireRole('admin'), (req, res, next) => {
	try {
		const unit = queryOne('SELECT * FROM units WHERE id = ?', [req.params.id]);
		if (!unit) return res.status(404).json({ status: 'error', message: 'Unit nicht gefunden' });
		// Lösche Unit und abhängige Inhalte in Transaktion
		const deleted = require('../db.js').transaction((db) => {
			db.prepare('DELETE FROM flashcards WHERE unit_id = ?').run([unit.id]);
			db.prepare('DELETE FROM questions WHERE unit_id = ?').run([unit.id]);
			db.prepare('DELETE FROM unit_sources WHERE unit_id = ?').run([unit.id]);
			db.prepare('DELETE FROM notes WHERE unit_id = ?').run([unit.id]);
			db.prepare('DELETE FROM bookmarks WHERE unit_id = ?').run([unit.id]);
			db.prepare('DELETE FROM units WHERE id = ?').run([unit.id]);
			return true;
		});
		res.json({ status: 'ok', deleted: unit.id });
	} catch (err) {
		next(err);
	}
});

export default router;
