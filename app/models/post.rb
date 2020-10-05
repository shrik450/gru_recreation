# typed: strict
class Post < ApplicationRecord
  extend T::Sig

  belongs_to :author_, class_name: "Author", foreign_key: :author
  has_many :comments, as: :parent, inverse_of: :parent
  has_many :all_comments, class_name: "Comment", inverse_of: :post
  has_many :codes, as: :reference, inverse_of: :reference
  has_many :ratings, -> { where(hidden: false) }, inverse_of: :post, dependent: :restrict_with_exception

  scope :image_present, -> { where(image_not_present: false) }
  scope :order_by_score, -> { order(score: :desc) }
  scope :rated_by, ->(user) { joins(:ratings).where(ratings: {user_id: user.id}) }
  scope :unrated_by, ->(user) { where.not(id: rated_by(user)) }

  scope :for_month, lambda {|month|
    from_date = DateTime.parse(month + "-01")
    end_date = from_date.end_of_month
    where(created_utc: (from_date..end_date)).image_present
  }

  scope :top_100_for_month, ->(month) { for_month(month).order_by_score.limit(100) }
  # This scope prevents a clash with the ransack sorts.
  scope :top_100_for_month_for_search, lambda {|month|
    posts = Post.all.top_100_for_month(month)
    # The LIMIT 100 doesn't seem to work very well when this scope
    # is called inside ransack.
    ids = posts.distinct.map(&:id)
    where(id: ids)
  }

  scope :top_100_for_any_month, lambda {|boolean=true|
    if boolean
      ids = ::STUDY_MONTHS.inject([]) {|ids, month|
        ids += Post.top_100_for_month(month).ids
      }
      Post.where(id: ids)
    else
      Post.all
    end
  }

  scope :random_top_100_post_unrated_by, lambda {|user|
    top_100_for_any_month.unrated_by(user).order("RANDOM()").limit(1).first
  }

  sig {params(_auth_object: T.untyped).returns(T::Array[Symbol])}
  def self.ransackable_scopes(_auth_object=nil)
    %i[top_100_for_month_for_search top_100_for_any_month]
  end

  sig {returns(T.nilable(Integer))}
  # Returns the rank of the post, if it was in the top 100.
  # Extremely inefficient.
  def rank
    created_utc = T.must(self.created_utc)
    month = "#{created_utc.year}-#{created_utc.month}"
    top_100 = Post.top_100_for_month(month)
    # byebug
    if top_100.find_by(id: id).present?
      top_100.pluck("id, RANK() OVER(ORDER BY score DESC)").to_h[id]
    end
  end
end
