class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    my_room_id = current_user.entries.pluck(:room_id)
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id).page(params[:page]).per(10)
  end
end
