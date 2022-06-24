from flask import Flask, render_template, abort, send_from_directory
from sqlalchemy import MetaData
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

convention = {
    "ix": 'ix_%(column_0_label)s',
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(constraint_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s"
}

metadata = MetaData(naming_convention=convention)
db = SQLAlchemy(app, metadata=metadata)
migrate = Migrate(app, db)

from models import Genre, Image, Book

from auth import bp as auth_bp, init_login_manager
from books import bp as books_bp
from reviews import bp as reviews_bp
app.register_blueprint(auth_bp)
app.register_blueprint(books_bp)
app.register_blueprint(reviews_bp)

init_login_manager(app)


@app.route('/')
def index():
    genres = Genre.query.all()
    return render_template('index.html', genres=genres)


@app.route('/images/<book_id>')
def image(book_id):
    img = Image.query.filter_by(book_id=book_id).first()
    if img is None:
        abort(404)
    return send_from_directory(app.config['UPLOAD_FOLDER'], img.storage_filename)
