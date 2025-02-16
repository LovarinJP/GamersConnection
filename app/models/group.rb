class Group < ApplicationRecord
  has_one_attached :image

  has_many :group_users, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :users, through: :group_users
  belongs_to :owner, class_name: "User"

  validates :name, presence: true
  validates :caption, length: { maximum: 150 }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

end
