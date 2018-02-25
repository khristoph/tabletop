class Game < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews

  validates_presence_of :description, :creator, :title

  has_attached_file :game_img,
   styles:
   { game_index: "250x350>", game_show: "339x475>" },
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :game_img, content_type: /\Aimage\/.*\z/

  def self.search(search)
    where("title ILIKE ? OR creator ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
