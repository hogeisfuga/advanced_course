class MessageRoom < ApplicationRecord
  has_many :message_room_users
  has_many :messages
  has_many :users, through: :message_room_users
end
