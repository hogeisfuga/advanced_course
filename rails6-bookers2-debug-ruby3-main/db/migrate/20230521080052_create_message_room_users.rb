class CreateMessageRoomUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :message_room_users do |t|
      t.integer :message_room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
