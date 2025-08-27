// Auth Utilities
import bcrypt from 'bcryptjs';

export function createPasswordHash(plain) {
	return bcrypt.hashSync(plain, 10);
}

export function verifyPassword(plain, hash) {
	return bcrypt.compareSync(plain, hash);
}

export function currentUser(req) {
	const user = req.session?.user;
	if (!user) return null;
	const { id, email, display_name, role } = user;
	return { id, email, display_name, role };
}

export function requireAuth(req, res, next) {
	if (!req.session?.user) {
		return res.status(401).json({ status: 'error', message: 'Nicht angemeldet' });
	}
	next();
}

export function requireRole(...roles) {
	return (req, res, next) => {
		const user = req.session?.user;
		if (!user || !roles.includes(user.role)) {
			return res.status(403).json({ status: 'error', message: 'Keine Berechtigung' });
		}
		next();
	};
}
