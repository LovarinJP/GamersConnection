class Public::GroupusersController < ApplicationController
  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    if group_user.save
      flash[:notice] = "グループに加入しました"
      redirect_to request.referer
    else
      flash[:alert] = "グループに加入できませんでした"
      redirect_to request.referer
    end
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    flash[:notice] = "グループから退会しました"
    redirect_to groups_path
  end

end
