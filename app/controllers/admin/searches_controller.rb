class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    word = params['word']
    @users = partical_user(word)
    @posts = partical_post(word)
    @groups = partical_group(word)
  end

  private

  def partical_user(word)
    User.where('nickname LIKE ?', "%#{word}%")
  end

  def partical_post(word)
    Post.where('body LIKE ?', "%#{word}%")
  end

  def partical_group(word)
    Group.where('name LIKE ?', "%#{word}%")
  end
end
