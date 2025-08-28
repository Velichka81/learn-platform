import express from 'express';
import { queryAll, queryOne, run } from '../db.js';
import { requireRole } from '../utils/auth.js';

const router = express.Router();

// Alle Units (einfacher Überblick)
router.get('/', (req, res) => {
  const units = queryAll('SELECT id, title FROM units ORDER BY id');
  res.json(units);
});

// Einzelne Unit inkl. counts (spiegelt Logik aus learning-routes wider)
router.get('/:id', (req, res, next) => {
  try {
    const unit = queryOne('SELECT id, title, summary, content_html FROM units WHERE id = ?', [req.params.id]);
    if (!unit) return res.status(404).json({ status: 'error', message: 'Unit nicht gefunden' });
    // Debug: Bytes anzeigen um Encoding-Probleme zu analysieren
    try {
      const bytesTitle = [...Buffer.from(unit.title, 'utf8')].map(b=>b.toString(16).padStart(2,'0')).join(' ');
      const bytesSummary = unit.summary ? [...Buffer.from(unit.summary, 'utf8')].map(b=>b.toString(16).padStart(2,'0')).join(' ') : '';
      console.log('[UTF8 DEBUG] title=', unit.title, 'bytes=', bytesTitle);
      if (unit.summary) console.log('[UTF8 DEBUG] summary=', unit.summary, 'bytes=', bytesSummary);
    } catch(e) { /* ignore */ }
    const flashcards = queryOne('SELECT COUNT(*) AS count FROM flashcards WHERE unit_id = ?', [unit.id]).count;
    const questions = queryOne('SELECT COUNT(*) AS count FROM questions WHERE unit_id = ?', [unit.id]).count;
    res.json({ ...unit, counts: { flashcards, questions } });
  } catch (err) {
    next(err);
  }
});

export default router;

// Units Route
