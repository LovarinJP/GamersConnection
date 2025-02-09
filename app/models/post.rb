class Post < ApplicationRecord
  has_one_attached :image

  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  belongs_to :user

  validates :body, presence: true, length: { maximum: 300 }

  def get_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    end
  end
end
