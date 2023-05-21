class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_room_id: params[:message_room_id], content: message_params[:content])
    if @message.save
      @room = MessageRoom.find(params[:message_room_id])
      @messages = @room.messages
    else
      render 'messages/message_error.js'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
