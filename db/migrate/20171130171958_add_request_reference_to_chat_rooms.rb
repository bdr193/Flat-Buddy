class AddRequestReferenceToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :chat_rooms, :request, foreign_key: true
  end
end
