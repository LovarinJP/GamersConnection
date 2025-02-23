class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @groups = Group.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end
end
