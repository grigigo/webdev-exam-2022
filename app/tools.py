import hashlib
import uuid
import os
from werkzeug.utils import secure_filename
from models import Book, Image
from app import db, app


class BooksFilter:
    def __init__(self, name):
        self.name = name
        self.query = Book.query

    def perform(self):
        self.__filter_by_name()
        return self.query.order_by(Book.year.desc())

    def __filter_by_name(self):
        if self.name:
            self.query = self.query.filter(Book.name.ilike('%' + self.name + '%'))


class ImageSaver:
    def __init__(self, file):
        self.file = file

    def save(self, book_id):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img

        file_name = secure_filename(self.file.filename)
        self.img = Image(file_name=file_name, mime_type=self.file.mimetype, md5_hash=self.md5_hash, book_id=book_id)
        db.session.add(self.img)
        db.session.commit()
        self.file.save(os.path.join(app.config['UPLOAD_FOLDER'], self.img.storage_filename))

        return self.img

    def __find_by_md5_hash(self):
        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()
        self.file.seek(0)
        return Image.query.filter(Image.md5_hash == self.md5_hash).first()
