class MessageRoomsController < ApplicationController
  def create
    if create_room
      redirect_to @room
    end
  end

  def show
    @room = MessageRoom.find(params[:id])
    @chat_with = @room.users.select {|user| user.id != current_user.id }
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
