class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def favorite
  end

  def follows
  end

  def followeds
  end
end
