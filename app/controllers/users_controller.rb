class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def info(opts = {})
    opts.each do |key, value|
      session[key.to_sym] = value
    end
  end

  def edit
    @lat = params[:search].nil? ? session[:lat] : params[:search][:lat]
    @lng = params[:search].nil? ? session[:lng] : params[:search][:lng]

    @move_in_date = params[:search].nil? ? session[:move_in_date] : params[:search][:move_in_date]
    @move_out_date = params[:search].nil? ? session[:move_out_date] : params[:search][:move_out_date]

    info(move_in_date: @move_in_date, move_out_date: @move_out_date, lat: @lat, lng: @lng)
  end

  def update
    if @user.update(user_params)
      redirect_to rooms_path
    else
      render :edit
    end


  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:art_museum,
    :art_photography,
    :art_theatre,
    :art_live,
    :art_cinema,
    :art_reading,
    :sport_ball,
    :sport_endurance,
    :sport_wellbeing,
    :sport_snow,
    :sport_extreme,
    :sport_watersports,
    :film_romcom,
    :film_action,
    :film_horror,
    :film_documentary,
    :film_animation,
    :film_scifi,
    :music_pop,
    :music_electronic,
    :music_classical,
    :music_rock,
    :music_jazz,
    :music_hiphop,
    :holiday_beach,
    :holiday_trek,
    :holiday_city,
    :holiday_party,
    :holiday_home,
    :holiday_historic,
    :food_vegetarian,
    :food_meat,
    :food_quick,
    :food_restaurant,
    :food_delivery,
    :food_drink)
  end
end
