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
app.use(morgan('dev'));
app.use(cookieSession({
		name: 'sid',
		secret: process.env.SESSION_SECRET || 'dev',
		httpOnly: true,
		sameSite: 'lax'
}));

app.get('/api/health', (req, res) => res.json({ ok: true }));

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
app.listen(PORT, () => {
	console.log(`Server läuft auf Port ${PORT}`);
});
