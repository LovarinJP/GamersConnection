# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(
  email: "admin@gmail.com",
  password: "password"
)

image_path = Rails.root.join('app', 'assets', 'images', 'no_image.jpg')

User.create!(
  [
    {
    email: "guest@example.com",
    password: Devise.friendly_token[0, 20],
    name: "ゲストユーザー",
    nickname: "ゲスト",
    caption: "これはゲストユーザーです
    様々な機能を試すことができます"
    },

    {
    email: "test@gmail.com",
    password: "aaaaaa",
    name: "test",
    nickname: "test",
    profile_image: { io: File.open(image_path), filename: 'no-image.jpg', content_type: 'image/jpeg'}
    }
]
)

Post.create(
  [
    {
    user_id: 1,
    body: "これはテスト投稿です"
    },

    {
    user_id: 2,
    body: "ゲームについていろいろ話したい！"
    }
  ]
)

Group.create(
  [
    {
    name: "test group",
    owner_id: 1,
    caption: "これはテストグループです"
    },

    {
    name: "Gamers",
    owner_id: 2,
    caption: "ゲーム好き集まれー！"
    }
  ]
)