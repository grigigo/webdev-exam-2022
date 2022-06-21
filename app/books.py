from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import current_user
from sqlalchemy.exc import IntegrityError

from app import db
from models import Genre, Book, User, Review
from tools import ImageSaver, BooksFilter

bp = Blueprint('books', __name__, url_prefix='/books')

BOOK_PARAMS = ['name', 'genres', 'year', 'author']

PER_PAGE = 10


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
    users = User.query.all()
    return render_template('books/new.html', genres=genres, users=users)


@bp.route('/create', methods=['POST'])
def create():
    f = request.files.get('background_img')
    if f and f.filename:
        img = ImageSaver(f).save()

    try:
        book = Book(**params(), image=img.id)
        db.session.add(book)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()

    flash(f"Курс {book.name} был успешно создан!", 'success')

    return redirect(url_for('books.index'))


# @bp.route('/<int:book_id>')
# def show(book_id):
#     book = Book.query.get(book_id)
#     reviews = Review.query.order_by(Review.created_at.desc()).filter(Review.course_id.ilike(course_id)).limit(5)
#     count = Review.query.order_by(Review.created_at.desc()).filter(Review.course_id.ilike(course_id)).count()
#     if current_user.is_authenticated:
#         user_review = Review.query.filter(Review.course_id.ilike(course_id)).filter(Review.user_id.ilike(current_user.id)).first()
#     return render_template('courses/show.html', course=course, reviews=reviews, user_review=user_review, review_count=count)


# @bp.route('/<int:course_id>/create_review', methods=['POST'])
# def create_review(course_id):
#     rating = request.form.get("user_rating_radio")
#     user_review = request.form.get('user_review')
#     par = {"user_id": current_user.id, "course_id": course_id, "review_rating": rating, "text_review": user_review}
#
#     course = Course.query.get(course_id)
#     course.reСount(rating)
#     db.session.add(course)
#     db.session.commit()
#
#     review = Review(**par)
#     db.session.add(review)
#     db.session.commit()
#
#     flash(f"Отзыв был успешно создан!", 'success')
#
#     return redirect(url_for('courses.show', course_id=course_id))
#
# @bp.route('/<int:course_id>/reviews')
# def reviews_show(course_id):
#     fil = request.args.get('fil', 0, type=int)
#     page = request.args.get('page', 1, type=int)
#     pagination = Review.query.paginate(page, PER_PAGE)
#
#     if fil == 0:
#         reviews = Review.query.order_by(Review.created_at.desc()).filter(Review.course_id.ilike(course_id)).limit(PER_PAGE).offset((page-1)*PER_PAGE)
#     elif fil == 1:
#         reviews = Review.query.order_by(Review.created_at.asc()).filter(Review.course_id.ilike(course_id)).limit(PER_PAGE).offset((page-1)*PER_PAGE)
#     elif fil == 2:
#         reviews = Review.query.order_by(Review.review_rating.desc()).filter(Review.course_id.ilike(course_id)).limit(PER_PAGE).offset((page-1)*PER_PAGE)
#     else:
#         reviews = Review.query.order_by(Review.review_rating.asc()).filter(Review.course_id.ilike(course_id)).limit(PER_PAGE).offset((page-1)*PER_PAGE)
#
#     return render_template('courses/reviews.html', reviews=reviews, fil=fil, pagination=pagination)
