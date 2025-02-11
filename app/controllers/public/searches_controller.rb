class Public::SearchesController < ApplicationController

  def search
    word = params['word']
    @users = partical_user(word)
    @posts = partical_post(word)
  end

  private

  def partical_user(word)
    User.where('nickname LIKE ?', "%#{word}%")
  end

  def partical_post(word)
    Post.where('body LIKE ?', "%#{word}%")
  end
end
