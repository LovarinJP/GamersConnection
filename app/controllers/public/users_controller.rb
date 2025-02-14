class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :check_guest, only: [:edit, :update]

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
    if @user.update(user_params)
      flash[:notice] = "編集に成功しました"
      redirect_to mypage_path(@user)
    else
      flash[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会完了しました"
    redirect_to new_user_registration_path
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

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :caption, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path(user)
    end
  end

  def check_guest
    if current_user.guest?
      flash[:alert] = "ゲストユーザは編集できません"
      redirect_to mypage_path(current_user)
    end
  end
end
