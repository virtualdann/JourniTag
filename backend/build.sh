#!/bin/bash
set -e

echo "Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Creating necessary directories..."
mkdir -p sql uploads/photos

echo "Initializing database..."
if [ ! -f "sql/greetings.db" ]; then
    echo "Creating new database..."
    python -c "from app import db; db.create_all()"
else
    echo "Database already exists, skipping creation..."
fi

echo "Build completed successfully!"
