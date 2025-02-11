class Comment < ApplicationRecord
  has_one_attached :image

  belongs_to :post
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 200 }

  def get_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    end
  end
end
