# typed: strict

class PostRatingService
  extend T::Sig

  sig{ params(posts: Post::ActiveRecord_Relation).returns(T::Hash[String, T::Hash[Symbol, Numeric]]) }
  def self.post_ratings_by_month(posts=Post.all)
    result = {}
    STUDY_MONTHS.each do |month|
      this_months_posts = posts.top_100_for_month(month).joins(:ratings)
      values = {}
      Rating.ratings.each do |rating, _value|
        values[rating.to_sym] = this_months_posts.where(ratings: {rating: rating}).distinct.count
      end
      result[month] = values
    end

    result
  end

  sig {params(user: User).returns(T::Hash[String, T::Hash[Symbol, Numeric]])}
  def self.post_ratings_by_month_by_user(user)
    posts = Post.joins(:ratings).where(ratings: {user_id: user})
    post_ratings_by_month posts
  end
end
