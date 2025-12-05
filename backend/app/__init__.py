"""Flask App initializer."""
import flask
from flask_cors import CORS
import os

# Flask Instance
app = flask.Flask(__name__)

# Session configuration (required for login/logout)
# Use environment variable for secret key in production
app.secret_key = os.environ.get('SECRET_KEY', 'journitag-secret-key-2024')
app.config['SESSION_COOKIE_SAMESITE'] = 'Lax'
app.config['SESSION_COOKIE_HTTPONLY'] = True

# CORS - must specify exact origin when using credentials (can't use wildcard *)
# Get allowed origins from environment variable or use default for development
frontend_url = os.environ.get('FRONTEND_URL', 'http://localhost:5173')
allowed_origins = [frontend_url, 'http://localhost:5173']  # Always allow localhost for dev
CORS(app, supports_credentials=True, origins=allowed_origins)

app.config.from_object('app.config')

from werkzeug.middleware.shared_data import SharedDataMiddleware
import os
app.wsgi_app = SharedDataMiddleware(app.wsgi_app, {
    '/uploads': os.path.join(app.root_path, '..', 'uploads')
})

from app import db
db.init_app(app)

from app import routes