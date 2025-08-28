import dotenv from 'dotenv';
dotenv.config();
import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import cookieSession from 'cookie-session';
import path from 'path';
import { fileURLToPath } from 'url';

import authRoutes from './routes/auth.js';
import learningRoutes from './routes/learning.js';
import unitsRoutes from './routes/units.js';
import flashcardsRoutes from './routes/flashcards.js';
import quizzesRoutes from './routes/quizzes.js';
import errorHandler from './middleware/errors.js';
import { ensureDevSeed } from './seed_dev.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
// CORS für alle API-Routen aktivieren (auch Preflight)
app.use(cors({
	origin: 'http://localhost:5173',
	credentials: true,
	methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
	allowedHeaders: ['Content-Type', 'Authorization'],
}));
app.options('*', cors());
app.use(express.json());
// Charset für alle JSON-Antworten sicherstellen
app.use((req, res, next) => {
	const json = res.json;
	res.json = function (body) {
		if (!res.get('Content-Type')) {
			res.set('Content-Type', 'application/json; charset=utf-8');
		}
		return json.call(this, body);
	};
	next();
});
app.use(morgan('dev'));
app.use(cookieSession({
		name: 'sid',
		secret: process.env.SESSION_SECRET || 'dev',
		httpOnly: true,
		sameSite: 'lax'
}));

app.get('/api/health', (req, res) => res.json({ ok: true }));
// Diagnose: Umlaut-Test
app.get('/api/test/umlaut', (req, res) => {
	res.json({ text: 'Überprüfung: ä ö ü Ä Ö Ü ß – § €' });
});

app.get('/', (req, res) => {
  res.send('<h1>API läuft! Siehe <a href="/api/learning-fields">/api/learning-fields</a></h1>');
});

app.use('/api/auth', authRoutes);
app.use('/api/learning-fields', learningRoutes);
app.use('/api/units', unitsRoutes);
app.use('/api/flashcards', flashcardsRoutes);
app.use('/api/quizzes', quizzesRoutes);

app.use(express.static(path.join(__dirname, '../public')));

app.use(errorHandler);

const PORT = process.env.API_PORT || 8090;
// Dev-Seed einmalig vor dem Start sicherstellen
ensureDevSeed();

app.listen(PORT, () => {
	console.log(`Server läuft auf Port ${PORT}`);
});
