class RoomsController < ApplicationController
  before_action :find_room_id, only: [:show, :edit]

  def index
    @neighborhoods = ["All neighborhoods", "Baker Street", "Battersea", "Bayswater", "Bermondsey", "Bethnal Green", "Brick Lane", "Brixton", "Brixton Hill", "Camberwell", "Chalk Farm", "Chelsea", "Clapham", "Clapham North", "Dalston", "Earls Court", "Elephant & Castle", "Finsbury", "Fitzrovia", "Fulham", "Hoxton", "Islington", "Kensington", "Kentish Town", "King's Cross", "Lower Holloway", "Maida Hill", "Marylebone", "Notting Hill", "Old Street", "Paddington", "Shadwell", "Shoreditch", "Southwark", "Spitalfields", "Stockwell", "Surrey Quays", "Swiss Cottage", "Vauxhall", "Wapping", "Waterloo", "West Brompton", "Whitechapel"]

    @lat =  session[:lat]
    @lng =  session[:lng]

    @move_in_date = session[:move_in_date]
    @move_out_date = session[:move_out_date]

    @flats_ids = Flat.near([@lat, @lng], 30).map(&:id)
    @rooms = Room.where(flat_id: @flats_ids)

    @rooms = @rooms.where("move_in_date <= ?", @move_in_date) unless @move_in_date.blank?

    @rooms = @rooms.where("move_out_date >= ?", @move_out_date) unless @move_out_date.blank?

    unless params[:room].nil?
      if params[:room][:neighborhood].present?
        @neighborhood = params[:room][:neighborhood]
        if @neighborhood == "All neighborhoods"
          @rooms = Room.all
        else
          @rooms = @rooms.select("*").joins(:flat).where(flats: { neighborhood: @neighborhood } )
        end
      end

      if params[:room][:number_of_flatmates].present?
        @flat_mates_value = params[:room][:number_of_flatmates]
        @number_of_flatmates = params[:room][:number_of_flatmates].size
        if params[:room][:number_of_flatmates].include? "➕"
          @rooms = @rooms.select("*").joins(:flat).where("flats.number_of_flatmates <= 10")
        else
          @rooms = @rooms.select("*").joins(:flat).where("flats.number_of_flatmates <= ?", @number_of_flatmates )
        end
      end

      if params[:room][:furnished].present?
        @furnished = params[:room][:furnished]
        case @furnished
        when "furnished"
          @rooms = @rooms.select("*").joins(:flat).where("flats.furnished = 2")
        when "semi-furnished"
          @rooms = @rooms.select("*").joins(:flat).where("flats.furnished = 1")
        when "unfurnished"
          @rooms = @rooms.select("*").joins(:flat).where("flats.furnished = 0")
        end
      end

      if params[:room][:monthly_price].present?
        @monthly_price = params[:room][:monthly_price]
        @rooms = @rooms.select("*").joins(:flat).where("flats.monthly_price <= ?", @monthly_price)
      end

      # if params[:room][:allow_students].present?
      #   @allow_students = params[:room][:allow_students]
      #   @rooms = @rooms.select("*").joins(:flat).where("flats.allow_students = ?", @allow_students)
      # end
      #
      @allow_students = params[:room][:allow_students] == "1"
      # if params[:room][:allow_pets].present?
      #   @allow_pets = params[:room][:allow_pets]
      #   @rooms = @rooms.select("*").joins(:flat).where("flats.allow_pets = ?", @allow_pets )
      # end
      @allow_pets = params[:room][:allow_pets] == "1"
      # if params[:room][:bills_included].present?
      #   @bills_included = params[:room][:bills_included]
      #   @rooms = @rooms.select("*").joins(:flat).where("flats.bills_included = ?", @bills_included)
      # end
      @bills_included = params[:room][:bills_included] == "1"
      #
      # if params[:room][:allow_smokers].present?
      #   @allow_smokers = params[:room][:allow_smokers]
      #   @rooms = @rooms.select("*").joins(:flat).where("flats.allow_smokers = ?", @allow_smokers)
      # end
      @allow_smokers = params[:room][:allow_smokers] == "1"

    end



    # @search = Search.new(search_params)
    # if @search.valid?
    # @rooms = Room.all
    # else
    #   render "pages/home"
    # end
  end

  def show
    @user = current_user
    @buddy = @room.flat.users.first
    @renter = @user.attributes.select{ |k,v| v.to_s == "true" }
    @owner = @buddy.attributes.select{ |k,v| v.to_s == "true" }
    @merge = @renter.to_a & @owner.to_a
    interest_array = @merge.flatten
    @interests = []
    x = 2
    interest_array.each_index do |index|
      if index % x == 0
        @interests << interest_array[index]
      end
    end

    @room_viewings = []
    @room.viewings.each do |viewing|
      string_viewing = viewing.start_time.strftime("%l:%M %P -  %A %eth %B")
      @room_viewings << string_viewing
    end
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
