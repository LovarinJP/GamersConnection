class Admin::UsersController < ApplicationController
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
  end

  def follows
    user = User.find(params[:id])
    @users = user.follows
  end

  def followeds
    user = User.find(params[:id])
    @users = user.followeds
  end
end
