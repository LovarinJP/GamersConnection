class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_post_path(params[:post_id])
  end
end
