from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import current_user
from app import db, app
from models import Genre, Book, User, Review

bp = Blueprint('reviews', __name__, url_prefix='/reviews')

PER_PAGE = 5


@bp.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    reviews = Review.query.filter(Review.user_id == current_user.id)
    count = Review.query.filter(Review.user_id == current_user.id).count()
    pagination = reviews.paginate(page, PER_PAGE)
    reviews = pagination.items
    return render_template('reviews/index.html', count=count, reviews=reviews, pagination=pagination, current_user=current_user)


@bp.route('/moder')
def moder():
    page = request.args.get('page', 1, type=int)
    reviews = Review.query.filter(Review.status_id == 1)
    count = Review.query.filter(Review.status_id == 1).count()
    pagination = reviews.paginate(page, PER_PAGE)
    reviews = pagination.items
    return render_template('reviews/moder.html', count=count, reviews=reviews, pagination=pagination)


@bp.route('/<int:review_id>')
def show(review_id):
    review = Review.query.get(review_id)
    return render_template('reviews/show.html', review=review)


@bp.route('/<int:review_id>/change_status', methods=['GET', 'POST'])
def change_status(review_id):
    review = Review.query.get(review_id)
    status_id = request.args.get('status_id')
    review.status_id = status_id
    db.session.add(review)
    db.session.commit()

    flash(f'Отзыв пользователя {review.user.full_name} {review.status.name}!', 'warning')

    return redirect(url_for('reviews.moder'))

