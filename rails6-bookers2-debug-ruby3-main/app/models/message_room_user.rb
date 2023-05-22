class MessageRoomUser < ApplicationRecord
  belongs_to :message_room
  belongs_to :user

  # メッセージ相手を返す
  def self.room_member_with(room_id, current_user_id)
    room_users = MessageRoomUser.where(message_room_id: room_id).where.not(user_id: current_user_id)
    room_users.last.user
  end
end
