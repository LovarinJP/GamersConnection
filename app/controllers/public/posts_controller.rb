class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:example]
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_editable, only: [:show, :edit]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
    #フォローしているユーザの投稿一覧を取得
    following_ids = current_user.follows.pluck(:id)
    @follow_posts = Post.where(user_id: following_ids).order(created_at: :desc).page(params[:page]).per(5)
    #いいねした投稿の一覧を取得
    favorites_post_ids = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites_post_ids).page(params[:page]).per(5)
  end

  def example
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @detail_page = true
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end


  def set_editable
    @post = Post.find(params[:id])
    @editable = (current_user == @post.user)
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end
end
