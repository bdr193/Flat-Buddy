class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def info(opts = {})
    opts.each do |key, value|
      session[key.to_sym] = value
    end
  end

  def index
    @neighborhoods = ["Baker Street", "Battersea", "Bayswater", "Bermondsey", "Bethnal Green", "Brick Lane", "Brixton", "Brixton Hill", "Camberwell", "Chalk Farm", "Chelsea", "Clapham", "Clapham North", "Dalston", "Earls Court", "Elephant & Castle", "Finsbury", "Fitzrovia", "Fulham", "Hoxton", "Islington", "Kensington", "Kentish Town", "King's Cross", "Lower Holloway", "Maida Hill", "Marylebone", "Notting Hill", "Old Street", "Paddington", "Shadwell", "Shoreditch", "Southwark", "Spitalfields", "Stockwell", "Surrey Quays", "Swiss Cottage", "Vauxhall", "Wapping", "Waterloo", "West Brompton", "Whitechapel"]

    @lat = params[:room][:lat] || session[:lat]
    @lng = params[:room][:lng] || session[:lng]

    @move_in_date = params[:room][:move_in_date] || session[:move_in_date]
    @move_out_date = params[:room][:move_out_date] || session[:move_out_date]

    @flats_ids = Flat.near([@lat, @lng], 30).map(&:id)
    @rooms = Room.where(flat_id: @flats_ids)

    @rooms = @rooms.where("move_in_date <= ?", @move_in_date) unless @move_in_date.blank?
    @rooms = @rooms.where("move_out_date >= ?", @move_out_date) unless @move_out_date.blank?

    if params[:room][:neighborhood].present?
      @neighborhood = params[:room][:neighborhood]
      @rooms = @rooms.select("*").joins(:flat).where(flats: { neighborhood: @neighborhood } )
    end

    if params[:room][:number_of_flatmates].present?
      @number_of_flatmates = params[:room][:number_of_flatmates]
      @rooms = @rooms.select("*").joins(:flat).where("flats.number_of_flatmates <= ?", @number_of_flatmates )
    end

    if params[:room][:monthly_price].present?
      @monthly_price = params[:room][:monthly_price]
      @rooms = @rooms.select("*").joins(:flat).where("flats.monthly_price <= ?", @monthly_price )
    end

    if params[:room][:has_parking].present?
      @has_parking = params[:room][:has_parking]
      @rooms = @rooms.select("*").joins(:flat).where("flats.has_parking = ?", @has_parking )
    end

    info(move_in_date: @move_in_date, move_out_date: @move_out_date, lat: @lat, lng: @lng)

    # allow_students
    # allow_pets
    # bills_included
    # allow_smokers
    # furnished
    # couples_allowed
    # ensuite
    # accessible
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
end
