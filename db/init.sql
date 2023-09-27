-- Create a new database
CREATE DATABASE my_database;

-- Connect to the newly created database
\c my_database;

-- Create a 'users' table
CREATE TABLE users (
    id serial PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create a 'categories' table
CREATE TABLE categories (
    id serial PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

-- Create a 'posts' table
CREATE TABLE posts (
    id serial PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    user_id INT REFERENCES users(id),
    category_id INT REFERENCES categories(id)
);

-- Create a 'comments' table
CREATE TABLE comments (
    id serial PRIMARY KEY,
    text TEXT NOT NULL,
    user_id INT REFERENCES users(id),
    post_id INT REFERENCES posts(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert some initial data into the 'users' table
INSERT INTO users (username, email) VALUES
    ('user1', 'user1@example.com'),
    ('user2', 'user2@example.com'),
    ('user3', 'user3@example.com');

-- Insert some initial data into the 'categories' table
INSERT INTO categories (name) VALUES
    ('Technology'),
    ('Science'),
    ('Travel');

-- Insert some initial data into the 'posts' table
INSERT INTO posts (title, content, user_id, category_id) VALUES
    ('Post 1', 'Content of Post 1', 1, 1),
    ('Post 2', 'Content of Post 2', 2, 2),
    ('Post 3', 'Content of Post 3', 3, 3);

-- Insert some initial data into the 'comments' table
INSERT INTO comments (text, user_id, post_id) VALUES
    ('Comment 1', 1, 1),
    ('Comment 2', 2, 1),
    ('Comment 3', 3, 2);
