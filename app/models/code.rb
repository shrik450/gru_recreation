# typed: false
class Code < ApplicationRecord
  belongs_to :reference, polymorphic: true, inverse_of: :codes
  belongs_to :user, inverse_of: :codes
end
