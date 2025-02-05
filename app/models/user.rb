class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
