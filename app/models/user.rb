class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  #投稿に関連するアソシエーション
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  #グループ機能に関するアソシエーション
  has_many :group_users, dependent: :destroy
  #DM機能に関するアソシエーション
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  #フォローに関するアソシエーション
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :follows, through: :follows, source: :followed
  #フォロワーに関するアソシエーション
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, through: :followeds, source: :follow

  validates :name, presence: true
  validates :nickname, presence: true
  validates :caption, length: { maximum: 150 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end
end
