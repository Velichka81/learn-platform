import express from 'express';
import { queryAll, queryOne, run } from '../db.js';
import { requireRole } from '../utils/auth.js';

const router = express.Router();

// Beispielroute (weitere Routen nach Bedarf ergänzen)
router.get('/', (req, res) => {
  const units = queryAll('SELECT id, title FROM units ORDER BY id');
  res.json(units);
});

export default router;

// Units Route
