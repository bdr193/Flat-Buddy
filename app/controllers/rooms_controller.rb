class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def index
    @search = Search.new(search_params)
    if @search.valid?
      @rooms = Room.all
    else
      render "pages/home"
    end
  end

  def show
    @room.viewings
    # @viewing_times = []
    # @room.viewings.each do |viewing|
    #   @viewing_times << viewing.start_time.to_s
    # end
    @hash = Gmaps4rails.build_markers(@room.flat) do |room, marker|
      marker.lat room.lat
      marker.lng room.lng
    end
    @room_photo = @room.flat.card_image
    @request = Request.new
    @room_amenities = @room.flat.amenities.split(",")
  end

  def new
  end

  def edit
  end

  def find_room_id
    @room = Room.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:city, :move_in_date, :move_out_date, :lat, :lng)
  end
end
