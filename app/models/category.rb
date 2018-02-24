class Category < ApplicationRecord
  has_many :games

  validates :name, presence:true
  validates :name, length: {maximum: 20}
end
