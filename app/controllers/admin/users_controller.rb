class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @detail_page = true
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会させました"
    redirect_to admin_users_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites_post_ids = Favorite.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.where(id: favorites_post_ids).page(params[:page]).per(5)
  end

  def follows
    user = User.find(params[:id])
    @users = user.follows.page(params[:page]).per(10)
  end

  def followeds
    user = User.find(params[:id])
    @users = user.followeds.page(params[:page]).per(10)
  end
end
