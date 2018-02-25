class Review < ApplicationRecord
  validates_presence_of :rating, :user, :game, :comment

  belongs_to :game
  belongs_to :user


end
