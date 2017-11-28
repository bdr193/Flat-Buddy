class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def index
    @rooms = Room.all
  end

  def show
    @viewing_times = []
    @room.viewings.each do |viewing|
      @viewing_times << viewing.start_time.to_s
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
