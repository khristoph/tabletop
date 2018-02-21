class Review < ApplicationRecord
  validates :rating, presence: true
  validates :comment, presence: true
  belongs_to :game
  belongs_to :user
end
