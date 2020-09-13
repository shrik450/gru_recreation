# typed: strict
class Post < ApplicationRecord
  extend T::Sig

  has_many :comments, as: :parent, inverse_of: :parent
  has_many :codes, as: :reference, inverse_of: :reference
  has_many :ratings, inverse_of: :post, dependent: :restrict_with_exception

  sig {params(month: String).returns(Post::ActiveRecord_Relation)}
  # Returns all posts for a given month.
  # @param [String] month in the form, "YYYY-mm".
  # @return [Post::ActiveRecord_Relation]
  def self.for_month(month)
    from_date = DateTime.parse(month + "-01")
    end_date = from_date.end_of_month
    where(created_utc: (from_date..end_date))
  end
end
