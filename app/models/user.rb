# typed: false
class User < ApplicationRecord
  has_secure_password

  has_many :codes, inverse_of: :user, dependent: :restrict_with_exception
  has_many :ratings, inverse_of: :user, dependent: :restrict_with_exception

  validates :email, uniqueness: true
end
