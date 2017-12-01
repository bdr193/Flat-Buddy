class ChatRoomsController < ApplicationController
  def show
    @chat_room = ChatRoom.includes(messages: :user).find(params[:id])
  end

  def create
    @request = Request.find(params[:request_id])
    @flat = @request.viewing.flat
    @chat_room = ChatRoom.create!(user_id: @request.user_id, name: @flat.title)
  end
end
