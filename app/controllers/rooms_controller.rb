class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def index
    @city = params[:room][:city] || session[:city]
    @move_in_date = params[:room][:move_in_date] || session[:move_in_date]
    @move_out_date = params[:room][:move_out_date] || session[:move_out_date]
    info(city: @city, move_in_date: @move_in_date, move_out_date: @move_out_date)
    @rooms = Room.all
  end

  def show
    @viewing_times = []
    @room.viewings.each do |viewing|
      @viewing_times << viewing.start_time.to_s
    end
    @hash = Gmaps4rails.build_markers(@room.flat) do |room, marker|
      marker.lat room.latitude
      marker.lng room.longitude
    end
    @room_photo = @room.flat.photos.first
    @request = Request.new
  end

  def new
  end

  def edit
  end

  def find_room_id
    @room = Room.find(params[:id])
  end
end
