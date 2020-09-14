class Rating < ApplicationRecord
  enum rating: {benign: 0, ambiguous: 1, hateful: 2}

  belongs_to :post, inverse_of: :ratings
  belongs_to :user, inverse_of: :ratings

  validates :user_id, uniqueness: {scope: %i[post_id]}
end
