-- Database: myapp
-- Schema for a fullstack notes app
-- Drop tables if they exist (for idempotent seeding during dev)
DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS users;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Notes table
CREATE TABLE notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_title (title)
) ENGINE=InnoDB;

-- Sample users
INSERT INTO users (username, email, password_hash) VALUES
('alice', 'alice@example.com', '$2b$10$abcdefghijklmnopqrstuv'), -- fake hash for demo
('bob', 'bob@example.com', '$2b$10$1234567890abcdefghijklm');  -- fake hash for demo

-- Sample notes (assuming inserted users get IDs 1 and 2)
INSERT INTO notes (user_id, title, content) VALUES
(1, 'Welcome Note', 'This is Alice''s first note!'),
(1, 'Shopping List', 'Milk\nBread\nCheese'),
(2, 'Bob''s Thought', 'I really like taking notes.'),
(2, 'Todo', '1. Build fullstack app\n2. ???\n3. Profit.');
