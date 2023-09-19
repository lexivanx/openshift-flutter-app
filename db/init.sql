-- Create a new database
CREATE DATABASE my_database;

-- Connect to the newly created database
\c my_database;

-- Create a table
CREATE TABLE users (
    id serial PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100)
);

-- Insert some initial data
INSERT INTO users (username, email) VALUES
    ('user1', 'user1@example.com'),
    ('user2', 'user2@example.com'),
    ('user3', 'user3@example.com');
