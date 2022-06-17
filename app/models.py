import os
from flask import url_for
from app import db
from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin
import sqlalchemy as sa

book_genre = db.Table('book_genre',
                         db.Column('book_id', db.Integer, db.ForeignKey('books.id')),
                         db.Column('genre_id', db.Integer, db.ForeignKey('genres.id')))


class Book(db.Model):
    __tablename__ = 'books'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), nullable=False)
    desc = db.Column(db.Text, nullable=False)
    year = db.Column(db.Integer, nullable=False)
    pub_house = db.Column(db.String(64), nullable=False)
    author = db.Column(db.String(64), nullable=False)
    page_count = db.Column(db.Integer, nullable=False)

    genres = db.relationship('Genre', secondary=book_genre, backref=db.backref('books'))

    def __repr__(self):
        return '<Book %r>' % self.name


class Genre(db.Model):
    __tablename__ = 'genres'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(16), nullable=False, unique=True)

    def __repr__(self):
        return '<Genre %r>' % self.name


class Image(db.Model):
    __tablename__ = 'images'

    id = db.Column(db.Integer, primary_key=True)
    file_name = db.Column(db.String(128), nullable=False)
    mime_type = db.Column(db.String(128), nullable=False)
    md5_hash = db.Column(db.String(256), nullable=False, unique=True)
    book_id = db.Column(db.Integer, db.ForeignKey('books.id'))

    book = db.relationship('Book', backref=db.backref('image'))

    def __repr__(self):
        return '<Image %r>' % self.file_name

    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.file_name)
        return str(self.id) + ext

    # @property
    # def url(self):
    #     return url_for('image', image_id=self.id)


CONST_STATUS = 1


class Review(db.Model):
    __tablename__ = 'reviews'

    id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('books.id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    review_rating = db.Column(db.Integer, nullable=False)
    text_review = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, nullable=False, server_default=sa.sql.func.now())
    status_id = db.Column(db.Integer, db.ForeignKey('status.id'), default=CONST_STATUS)

    status = db.relationship('Status', backref=db.backref('reviews'))
    book = db.relationship('Book', backref=db.backref('reviews'))
    user = db.relationship('User', backref=db.backref('reviews'))

    def __repr__(self):
        return '<Review %r>' % self.text_review


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    login = db.Column(db.String(32), nullable=False, unique=True)
    password_hash = db.Column(db.String(256), nullable=False)
    last_name = db.Column(db.String(16), nullable=False)
    first_name = db.Column(db.String(16), nullable=False)
    middle_name = db.Column(db.String(16))
    role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))

    role = db.relationship('Role', backref=db.backref('users'))

    def __repr__(self):
        return '<User %r>' % self.name

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])


class Role(db.Model):
    __tablename__ = 'roles'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(16), nullable=False)
    desc = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return '<Role %r>' % self.name


class Status(db.Model):
    __tablename__ = 'status'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(16), nullable=False)
