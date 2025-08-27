// Auth Route
import express from 'express';
import { z } from 'zod';
import { queryOne, run } from '../db.js';
import { createPasswordHash, verifyPassword, currentUser } from '../utils/auth.js';
import { issueCsrf, requireCsrf } from '../utils/csrf.js';

const router = express.Router();

const registerSchema = z.object({
	email: z.string().email(),
	password: z.string().min(8),
	display_name: z.string().min(2),
	csrf: z.string()
});

const loginSchema = z.object({
	email: z.string().email(),
	password: z.string().min(8),
	csrf: z.string()
});

router.post('/register', requireCsrf, async (req, res, next) => {
	try {
		const { email, password, display_name } = registerSchema.parse(req.body);
		if (queryOne('SELECT id FROM users WHERE email = ?', [email])) {
			return res.status(400).json({ status: 'error', message: 'E-Mail bereits registriert' });
		}
		const hash = createPasswordHash(password);
		const result = run(
			'INSERT INTO users (email, password_hash, display_name, role, created_at) VALUES (?, ?, ?, ?, datetime("now"))',
			[email, hash, display_name, 'learner']
		);
		const user = queryOne('SELECT id, email, display_name, role FROM users WHERE id = ?', [result.lastInsertRowid]);
		req.session.user = user;
		res.json({ status: 'ok', user });
	} catch (err) {
		if (err instanceof z.ZodError) {
			return res.status(400).json({ status: 'error', message: 'Ungültige Eingaben', details: err.errors });
		}
		next(err);
	}
});

router.post('/login', requireCsrf, async (req, res, next) => {
	try {
		const { email, password } = loginSchema.parse(req.body);
		const userRow = queryOne('SELECT * FROM users WHERE email = ?', [email]);
		if (!userRow || !verifyPassword(password, userRow.password_hash)) {
			return res.status(401).json({ status: 'error', message: 'Login fehlgeschlagen' });
		}
		const user = { id: userRow.id, email: userRow.email, display_name: userRow.display_name, role: userRow.role };
		req.session.user = user;
		res.json({ status: 'ok', user });
	} catch (err) {
		if (err instanceof z.ZodError) {
			return res.status(400).json({ status: 'error', message: 'Ungültige Eingaben', details: err.errors });
		}
		next(err);
	}
});

router.post('/logout', requireCsrf, (req, res) => {
	req.session = null;
	res.json({ status: 'ok' });
});

router.get('/me', (req, res) => {
	const user = currentUser(req);
	const csrf = issueCsrf(req.session);
	res.json({ user, csrf });
});

export default router;
