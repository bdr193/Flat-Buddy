class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def find_room_id
    @room = Room.find(params[:id])
  end
end
