# typed: strict
class Comment < ApplicationRecord
  belongs_to :parent, polymorphic: true, inverse_of: :comments, optional: true
  has_many :comments, as: :parent
end
