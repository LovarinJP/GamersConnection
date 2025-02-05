class Post < ApplicationRecord
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  belongs_to :user

  validates :body, length: { maximum: 300 }
end
