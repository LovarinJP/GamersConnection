class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to mypage_path(@user)
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to new_user_registration_path
  end

  def favorite
  end

  def follows
  end

  def followeds
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :caption, :profile_image)
  end
end
