// CSRF Utilities
import crypto from 'crypto';

export function issueCsrf(session) {
	const token = crypto.randomBytes(32).toString('hex');
	session.csrf = token;
	return token;
}

export function requireCsrf(req, res, next) {
	const token = req.headers['x-csrf-token'] || req.body?.csrf;
	if (!token || token !== req.session?.csrf) {
		return res.status(403).json({ status: 'error', message: 'CSRF-Token ungültig oder fehlt' });
	}
	next();
}
