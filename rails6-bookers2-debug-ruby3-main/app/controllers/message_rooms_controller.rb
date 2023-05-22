class MessageRoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    if create_room
      redirect_to @room
    end
  end

  def show
    @room = MessageRoom.find(params[:id])
    @with_user = MessageRoomUser.room_member_with(@room.id, current_user.id)
    unless current_user.mutual_follower?(@with_user)
      redirect_to users_path
      flash[:notice] = '相互フォローしていないためメッセージを送ることはできません。'
    end
    @messages = @room.messages.order(:id)
  end

  private

  def create_room
    ActiveRecord::Base.transaction do
      @room = MessageRoom.create
      user = User.find(params[:user_id])
      @room.message_room_users.create(user_id: user.id)
      @room.message_room_users.create(user_id: current_user.id)
    end
    true
  end

end
