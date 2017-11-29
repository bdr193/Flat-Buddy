class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def info(opts = {})
    opts.each do |key, value|
      session[key.to_sym] = value
    end
  end

  def index


    if params[:room]
       # @flats = Flat.joins(:rooms).near([params[:room][:lat],params[:room][:lng]], 15)
      if params[:room][:city]
        @flats_ids = Flat.near([52.5075681, 13.3994533], 15).map(&:id)
        @rooms = Room.where(flat_id: @flats_ids)
      else
        @rooms = Room.all
      end
      @rooms = @rooms.where("move_in_date < ?", params[:room][:move_in_date]) unless params[:room][:move_in_date].blank?
      @rooms = @rooms.where("move_out_date > ?", params[:room][:move_out_date]) unless params[:room][:move_out_date].blank?
      # raise # delete after AR
      # @rooms = @flats.joins(:rooms)
      # @rooms = @rooms.where(:room => { move_in_date: params[:room][:move_in_date]}) if params[:room][:move_in_date]
      # @rooms = @rooms.where(:room => { move_out_date: params[:room][:move_out_date]}) if params[:room][:move_out_date]

      # info( move_in_date: params[:room][:move_in_date], params[:room][:move_out_date])

    else
      @rooms = Room.all
    end
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
