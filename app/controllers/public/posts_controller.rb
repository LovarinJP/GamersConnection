class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_editable, only: [:show, :edit]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @post_detail = true
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
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
end
