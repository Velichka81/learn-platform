-- SQLite-Schema für Lernplattform
PRAGMA foreign_keys=ON;

-- Nutzerkonten
CREATE TABLE users (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	email TEXT UNIQUE NOT NULL,
	password_hash TEXT NOT NULL,
	display_name TEXT NOT NULL,
	role TEXT NOT NULL CHECK(role IN ('admin','author','learner')),
	created_at TEXT NOT NULL
);
CREATE INDEX idx_users_email ON users(email);

-- Lernfelder
CREATE TABLE learning_fields (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	code TEXT NOT NULL,
	title TEXT NOT NULL,
	exam_phase TEXT NOT NULL CHECK(exam_phase IN ('AP1','AP2')),
	position INTEGER NOT NULL
);
CREATE INDEX idx_learning_fields_position ON learning_fields(position);

-- Kapitel
CREATE TABLE chapters (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	learning_field_id INTEGER NOT NULL,
	title TEXT NOT NULL,
	position INTEGER NOT NULL,
	FOREIGN KEY (learning_field_id) REFERENCES learning_fields(id) ON DELETE CASCADE
);
CREATE INDEX idx_chapters_lf_pos ON chapters(learning_field_id, position);

-- Themen
CREATE TABLE topics (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	chapter_id INTEGER NOT NULL,
	title TEXT NOT NULL,
	position INTEGER NOT NULL,
	FOREIGN KEY (chapter_id) REFERENCES chapters(id) ON DELETE CASCADE
);
CREATE INDEX idx_topics_chapter_pos ON topics(chapter_id, position);

-- Einheiten
CREATE TABLE units (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	topic_id INTEGER NOT NULL,
	title TEXT NOT NULL,
	summary TEXT,
	content_html TEXT,
	FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);
CREATE INDEX idx_units_topic ON units(topic_id);

-- PDF-Quellen
CREATE TABLE pdf_sources (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	filename TEXT NOT NULL,
	storage_path TEXT NOT NULL,
	uploaded_by INTEGER NOT NULL,
	meta_json TEXT,
	FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Zuordnung Einheiten zu PDFs
CREATE TABLE unit_sources (
	unit_id INTEGER NOT NULL,
	pdf_id INTEGER NOT NULL,
	page_range TEXT,
	PRIMARY KEY (unit_id, pdf_id),
	FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE,
	FOREIGN KEY (pdf_id) REFERENCES pdf_sources(id) ON DELETE CASCADE
);

-- Lernkarten
CREATE TABLE flashcards (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	unit_id INTEGER NOT NULL,
	question TEXT NOT NULL,
	answer TEXT NOT NULL,
	difficulty INTEGER,
	FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE
);
CREATE INDEX idx_flashcards_unit ON flashcards(unit_id);

-- Lernkarten-Fortschritt
CREATE TABLE flashcard_progress (
	user_id INTEGER NOT NULL,
	flashcard_id INTEGER NOT NULL,
	box INTEGER NOT NULL,
	next_due TEXT,
	last_result TEXT,
	PRIMARY KEY (user_id, flashcard_id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (flashcard_id) REFERENCES flashcards(id) ON DELETE CASCADE
);
CREATE INDEX idx_flashcard_progress_due ON flashcard_progress(next_due);

-- Quizze
CREATE TABLE quizzes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	unit_id INTEGER,
	scope TEXT NOT NULL CHECK(scope IN ('unit','lf','ap1','ap2')),
	title TEXT NOT NULL,
	config_json TEXT,
	FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE SET NULL
);

-- Fragen
CREATE TABLE questions (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	quiz_id INTEGER,
	unit_id INTEGER,
	type TEXT NOT NULL CHECK(type IN ('mc','sc','tf','gap','match')),
	stem TEXT NOT NULL,
	explanation TEXT,
	FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
	FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE SET NULL
);
CREATE INDEX idx_questions_quiz ON questions(quiz_id);

-- Antwortoptionen
CREATE TABLE options (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	question_id INTEGER NOT NULL,
	label TEXT NOT NULL,
	is_correct INTEGER NOT NULL CHECK(is_correct IN (0,1)),
	FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);
CREATE INDEX idx_options_question ON options(question_id);

-- Quiz-Versuche
CREATE TABLE attempts (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	quiz_id INTEGER,
	user_id INTEGER NOT NULL,
	started_at TEXT NOT NULL,
	finished_at TEXT,
	score REAL,
	detail_json TEXT,
	scope TEXT,
	scope_ref TEXT,
	FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE SET NULL,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bookmarks
CREATE TABLE bookmarks (
	user_id INTEGER NOT NULL,
	unit_id INTEGER NOT NULL,
	PRIMARY KEY (user_id, unit_id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE
);

-- Notizen
CREATE TABLE notes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER NOT NULL,
	unit_id INTEGER NOT NULL,
	content TEXT NOT NULL,
	created_at TEXT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE
);
