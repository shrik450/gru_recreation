class Author < ApplicationRecord
  has_many :posts, foreign_key: "author"
  has_many :comments, foreign_key: "author"
end
