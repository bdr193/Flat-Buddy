class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def info(opts = {})
    opts.each do |key, value|
      session[key.to_sym] = value
    end
  end

  def index
    @neighborhoods = ["Baker Street", "Battersea", "Bayswater", "Bermondsey", "Bethnal Green", "Brick Lane", "Brixton", "Brixton Hill", "Camberwell", "Chalk Farm", "Chelsea", "Clapham", "Clapham North", "Dalston", "Earls Court", "Elephant & Castle", "Finsbury", "Fitzrovia", "Fulham", "Hoxton", "Islington", "Kensington", "Kentish Town", "King's Cross", "Lower Holloway", "Maida Hill", "Marylebone", "Notting Hill", "Old Street", "Paddington", "Shadwell", "Shoreditch", "Southwark", "Spitalfields", "Stockwell", "Surrey Quays", "Swiss Cottage", "Vauxhall", "Wapping", "Waterloo", "West Brompton", "Whitechapel"]

    @lat = params[:search].nil? ? session[:lat] : params[:search][:lat]
    @lng = params[:search].nil? ? session[:lng] : params[:search][:lng]

    @move_in_date = session[:move_in_date] || params[:search][:move_in_date]
    @move_out_date = session[:move_out_date] || params[:search][:move_out_date]

    @flats_ids = Flat.near([@lat, @lng], 30).map(&:id)
    @rooms = Room.where(flat_id: @flats_ids)

    @rooms = @rooms.where("move_in_date <= ?", @move_in_date) unless @move_in_date.blank?
    @rooms = @rooms.where("move_out_date >= ?", @move_out_date) unless @move_out_date.blank?

    unless params[:room].nil?
      if params[:room][:neighborhood].present?
        @neighborhood = params[:room][:neighborhood]
        @rooms = @rooms.select("*").joins(:flat).where(flats: { neighborhood: @neighborhood } )
      end

      if params[:room][:number_of_flatmates].present?
        @number_of_flatmates = params[:room][:number_of_flatmates].size
        if params[:room][:number_of_flatmates].include? "➕"
          @rooms = @rooms.select("*").joins(:flat).where("flats.number_of_flatmates >= ?", @number_of_flatmates )
        else
          @rooms = @rooms.select("*").joins(:flat).where("flats.number_of_flatmates <= ?", @number_of_flatmates )
        end
      end

      if params[:room][:monthly_price].present?
        @monthly_price = params[:room][:monthly_price]
        @rooms = @rooms.select("*").joins(:flat).where("flats.monthly_price <= ?", @monthly_price )
      end

      if params[:room][:allow_students].present?
        @allow_students = params[:room][:allow_students]
        @rooms = @rooms.select("*").joins(:flat).where("flats.allow_students = ?", @allow_students )
      end

      if params[:room][:allow_pets].present?
        @allow_pets = params[:room][:allow_pets]
        @rooms = @rooms.select("*").joins(:flat).where("flats.allow_pets = ?", @allow_pets )
      end

      if params[:room][:couples_allowed].present?
        @couples_allowed = params[:room][:couples_allowed]
        @rooms = @rooms.select("*").joins(:flat).where("flats.couples_allowed = ?", @couples_allowed )
      end

      if params[:room][:ensuite].present?
        @ensuite = params[:room][:ensuite]
        @rooms = @rooms.select("*").joins(:flat).where("flats.ensuite = ?", @ensuite )
      end

      if params[:room][:accessible].present?
        @accessible = params[:room][:accessible]
        @rooms = @rooms.select("*").joins(:flat).where("flats.accessible = ?", @accessible )
      end
      
    end

    info(move_in_date: @move_in_date, move_out_date: @move_out_date, lat: @lat, lng: @lng)

    # bills_included
    # allow_smokers
    # furnished


    # @search = Search.new(search_params)
    # if @search.valid?
    # @rooms = Room.all
    # else
    #   render "pages/home"
    # end
  end

  def show
    @room.viewings
    # @viewing_times = []
    # @room.viewings.each do |viewing|
    #   @viewing_times << viewing.start_time.to_s
    # end
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

  def search_params
    search = params.require(:search).permit(:city, :move_in_date, :move_out_date, :lat, :lng) unless params[:search].nil?
    room = params.require(:room).permit(:neighborhood, :number_of_flatmates, :furnished, :monthly_price, :bills_included, :ensuite, :accessible, :allow_students, :allow_pets, :couples_allowed, :allow_smokers) unless params[:room].nil?
    return search || room
  end
end
