# typed: strict
class Post < ApplicationRecord
  has_many :comments, as: :parent, inverse_of: :parent
end
