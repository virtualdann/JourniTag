#!/bin/bash
set -e

echo "Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Creating necessary directories..."
mkdir -p sql uploads/photos

echo "Initializing database..."
if [ ! -f "sql/greetings.db" ]; then
    echo "Creating new database from SQL files..."
    sqlite3 sql/greetings.db < sql/schema.sql
    sqlite3 sql/greetings.db < sql/data.sql
    sqlite3 sql/greetings.db < sql/add_auth.sql
    sqlite3 sql/greetings.db < sql/add_access_control.sql
    sqlite3 sql/greetings.db < sql/add_friend_requests.sql
    echo "Database created successfully!"
else
    echo "Database already exists, skipping creation..."
fi

echo "Build completed successfully!"
