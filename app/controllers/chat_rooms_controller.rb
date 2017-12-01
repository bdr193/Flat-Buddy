class ChatRoomsController < ApplicationController
  def show
    @chat_room = ChatRoom.includes(messages: :user).find(params[:id])
    @request = @chat_room.request
    @chat_room = @request.chat_room
  end
end
