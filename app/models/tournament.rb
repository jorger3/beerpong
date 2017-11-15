class Tournament < ApplicationRecord
  has_many :matches
  belongs_to :user, optional: false
end
