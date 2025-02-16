class Public::PermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    flash[:notice] = "グループへの参加申請をしました"
    redirect_to request.referer
  end

  def destroy
    permit = current_user.permits.find_by(group_id: params[:group_id])
    permit.destroy
    flash[:notice] = "グループへの参加申請を取り消しました"
    redirect_to request.referer
  end
end
