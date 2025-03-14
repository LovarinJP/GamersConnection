class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "グループ作成に成功しました"
      redirect_to group_path(@group)
    else
      flash.now[:alert] = "グループ作成に失敗しました"
      render :new
    end
  end

  def index
    @groups = Group.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
    @detail_page = true
    @permits = @group.permits.page(params[:page]).per(10)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "グループ情報の編集に成功しました"
      redirect_to group_path(@group)
    else
      flash.now[:alert] = "グループ情報の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループを削除しました"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :caption, :image)
  end

  def is_matching_login_user
    group = Group.find(params[:id])
    unless group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
