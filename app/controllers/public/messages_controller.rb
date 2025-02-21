class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :block_notrelated_users, only: [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)
    unless entries.nil?
      @room = entries.room
    else
      @room = Room.new
      @room.save
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: @user.id, room_id: @room.id)
    end

    @messages = @room.messages
    @message = Message.new(room_id: @room.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.save
  end

  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:message, :room_id)
  end

  def block_notrelated_users
    user = User.find(params[:id])
    unless current_user.follows?(user) && user.follows?(current_user)
      redirect_to mypage_path(current_user)
    end
  end
end
