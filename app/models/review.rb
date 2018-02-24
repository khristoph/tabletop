class Review < ApplicationRecord
  validates :rating, presence: true
  validates :comment, presence: true
  belongs_to :game
  belongs_to :user

validates :user, presence:true
validates :game, presence:true
validates :rating, presence:true
validates :comment, presence:true
end
