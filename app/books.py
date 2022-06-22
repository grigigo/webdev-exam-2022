from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import current_user
from sqlalchemy.exc import IntegrityError

from app import db
from models import Genre, Book, User, Review, book_genre
from tools import ImageSaver, BooksFilter

bp = Blueprint('books', __name__, url_prefix='/books')

BOOK_PARAMS = ['name', 'desc', 'year', 'author', 'pub_house', 'page_count']

PER_PAGE = 5


def params():
    return {p: request.form.get(p) for p in BOOK_PARAMS}


def search_params():
    return {
        'name': request.args.get('name'),
        'genre_ids': request.args.getlist('genre_ids')
    }


@bp.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    books = BooksFilter(**search_params()).perform()
    pagination = books.paginate(page, PER_PAGE)
    books = pagination.items
    genres = Genre.query.all()
    return render_template('books/index.html', books=books, genres=genres, search_params=search_params(),
                           pagination=pagination, current_user=current_user)


@bp.route('/new')
def new():
    # Проверка на администратора
    genres = Genre.query.all()
    return render_template('books/new.html', genres=genres)


@bp.route('/create', methods=['POST'])
def create():

    book = Book(**params())

    try:
        db.session.add(book)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()

    genre_list = request.form.getlist('genres')
    temp = Genre.query.filter(Genre.id.in_(genre_list))
    for gnr in temp:
        book.genres.append(gnr)
    db.session.commit()

    f = request.files.get('background_img')
    if f and f.filename:
        img = ImageSaver(f).save(book.id)

    flash(f"Курс {book.name} был успешно создан!", 'success')

    return redirect(url_for('books.index'))


@bp.route('/<int:book_id>')
def show(book_id):
    book = Book.query.get(book_id)
    reviews = Review.query.order_by(Review.created_at.desc()).filter(Review.book_id.ilike(book_id)).limit(5)
    count = Review.query.order_by(Review.created_at.desc()).filter(Review.book_id.ilike(book_id)).count()
    genres = book.genres
    if current_user.is_authenticated:
        user_review = Review.query.filter(Review.book_id.ilike(book_id)).filter(Review.user_id.ilike(current_user.id)).first()
    return render_template('books/show.html', book=book, reviews=reviews, user_review=user_review, review_count=count, genres=genres)


@bp.route('/<int:book_id>/create_review', methods=['POST'])
def create_review(book_id):
    rating = request.form.get("user_rating_radio")
    user_review = request.form.get('user_review')
    par = {"user_id": current_user.id, "book_id": book_id, "review_rating": rating, "text_review": user_review}

    book = Book.query.get(book_id)
    book.reCount(rating)
    db.session.add(book)
    db.session.commit()

    review = Review(**par)
    db.session.add(review)
    db.session.commit()

    flash(f"Отзыв был успешно создан!", 'success')

    return redirect(url_for('books.show', book_id=book_id))


@bp.route('/<int:book_id>/reviews')
def reviews_show(book_id):
    fil = request.args.get('fil', 0, type=int)
    page = request.args.get('page', 1, type=int)

    if fil == 0:
        reviews = Review.query.order_by(Review.created_at.desc()).filter(Review.book_id.ilike(book_id))
    elif fil == 1:
        reviews = Review.query.order_by(Review.created_at.asc()).filter(Review.book_id.ilike(book_id))
    elif fil == 2:
        reviews = Review.query.order_by(Review.review_rating.desc()).filter(Review.book_id.ilike(book_id))
    else:
        reviews = Review.query.order_by(Review.review_rating.asc()).filter(Review.book_id.ilike(book_id))

    pagination = reviews.paginate(page, PER_PAGE)
    reviews = pagination.items
    return render_template('books/reviews.html', reviews=reviews, fil=fil, pagination=pagination)
