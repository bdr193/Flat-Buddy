class RequestsController < ApplicationController

  def index
    @requests = Request.all.where(user_id: current_user.id)
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @viewing = Viewing.find(params[:viewing_id])
    @request = Request.new
  end

  def create
    @viewing = Viewing.find(request_params[:viewing_id])
    @request = Request.new
    @request.status = "pending"
    @request.user = current_user
    @request.viewing = @viewing
    if @request.save
      redirect_to request_path(@request)
      @flat = @request.viewing.room.flat
      @chat_room = ChatRoom.create!(request_id: @request.id, name: @flat.title)
      redirect_to requests_path
    else
      render :new
    end
  end
  def request_params
    params.require(:request).permit(:viewing_id)
  end
end
