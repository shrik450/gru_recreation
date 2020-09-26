# typed: strict

class PostRatingService
  extend T::Sig

  sig {returns(T::Hash[String, T::Hash[Symbol, Numeric]])}
  def self.post_ratings_by_month
    result = {}
    STUDY_MONTHS.each do |month|
      posts = Post.top_100_for_month(month).joins(:ratings)
      values = {}
      Rating.ratings.each do |rating, _value|
        values[rating.to_sym] = posts.where(ratings: {rating: rating}).distinct.count
      end
      result[month] = values
    end

    result
  end
end
