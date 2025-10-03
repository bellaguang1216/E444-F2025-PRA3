# project/models.py
from project.app import db

class Post(db.Model):
    __tablename__ = "post"   # make sure the table name matches your queries

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    text = db.Column(db.String(500), nullable=False)

    def __init__(self, title, text):
        self.title = title
        self.text = text

    def __repr__(self):
        return f"<Post {self.title}>"
