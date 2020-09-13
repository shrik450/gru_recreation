# typed: strict
class Post < ApplicationRecord
  has_many :comments, as: :parent, inverse_of: :parent
  has_many :codes, as: :reference, inverse_of: :reference
  has_many :ratings, inverse_of: :post, dependent: :restrict_with_exception
end
