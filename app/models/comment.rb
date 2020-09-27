# typed: strict
class Comment < ApplicationRecord
  # <tt>optional: true</tt> is necessary for now since there's comments from months
  # there are no posts from.
  belongs_to :parent, polymorphic: true, inverse_of: :comments, optional: true
  belongs_to :author_, class_name: "Author", foreign_key: :author, optional: true
  has_many :comments, as: :parent
  has_many :codes, as: :reference, inverse_of: :reference
end
