# typed: false
class Post < ApplicationRecord
  extend T::Sig

  has_many :comments, as: :parent, inverse_of: :parent
  has_many :codes, as: :reference, inverse_of: :reference
  has_many :ratings, inverse_of: :post, dependent: :restrict_with_exception

  scope :order_by_score, -> { order("score desc") }
  scope :rated_by, ->(user) { joins(:ratings).where(ratings: {user_id: user.id}) }
  scope :unrated_by, ->(user) { where.not(id: rated_by(user)) }

  sig {params(month: String).returns(Post::ActiveRecord_Relation)}
  # Returns all posts for a given month.
  # @param [String] month in the form, "YYYY-mm".
  # @return [Post::ActiveRecord_Relation]
  def self.for_month(month)
    from_date = DateTime.parse(month + "-01")
    end_date = from_date.end_of_month
    where(created_utc: (from_date..end_date))
  end

  sig {params(month: String).returns(Post::ActiveRecord_Relation)}
  def self.top_100_for_month(month)
    for_month(month).order_by_score.limit(100)
  end

  sig {returns(Post::ActiveRecord_Relation)}
  def self.top_100_for_any_month
    return @top_100_for_any_month if @top_100_for_any_month.present?

    ids = ::STUDY_MONTHS.inject([]) {|ids, month|
      ids += top_100_for_month(month).ids
    }
    @top_100_for_any_month = Post.where(id: ids)
  end

  sig {params(user: User).returns(T.nilable(Post))}
  def self.random_top_100_post_unrated_by(user)
    top_100_for_any_month.unrated_by(user).order("RANDOM()").limit(1).first
  end
end
