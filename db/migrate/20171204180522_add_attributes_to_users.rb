class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :art_museum, :boolean, default: false
    add_column :users, :art_photography, :boolean, default: false
    add_column :users, :art_theatre, :boolean, default: false
    add_column :users, :art_live, :boolean, default: false
    add_column :users, :art_cinema, :boolean, default: false
    add_column :users, :art_reading, :boolean, default: false
    add_column :users, :sport_ball, :boolean, default: false
    add_column :users, :sport_endurance, :boolean, default: false
    add_column :users, :sport_wellbeing, :boolean, default: false
    add_column :users, :sport_snow, :boolean, default: false
    add_column :users, :sport_extreme, :boolean, default: false
    add_column :users, :sport_watersports, :boolean, default: false
    add_column :users, :film_romcom, :boolean, default: false
    add_column :users, :film_action, :boolean, default: false
    add_column :users, :film_horror, :boolean, default: false
    add_column :users, :film_documentary, :boolean, default: false
    add_column :users, :film_animation, :boolean, default: false
    add_column :users, :film_scifi, :boolean, default: false
    add_column :users, :music_pop, :boolean, default: false
    add_column :users, :music_electronic, :boolean, default: false
    add_column :users, :music_classical, :boolean, default: false
    add_column :users, :music_rock, :boolean, default: false
    add_column :users, :music_jazz, :boolean, default: false
    add_column :users, :music_hiphop, :boolean, default: false
    add_column :users, :holiday_beach, :boolean, default: false
    add_column :users, :holiday_trek, :boolean, default: false
    add_column :users, :holiday_city, :boolean, default: false
    add_column :users, :holiday_party, :boolean, default: false
    add_column :users, :holiday_home, :boolean, default: false
    add_column :users, :holiday_historic, :boolean, default: false
    add_column :users, :food_vegetarian, :boolean, default: false
    add_column :users, :food_meat, :boolean, default: false
    add_column :users, :food_quick, :boolean, default: false
    add_column :users, :food_restaurant, :boolean, default: false
    add_column :users, :food_delivery, :boolean, default: false
    add_column :users, :food_drink, :boolean, default: false
  end
end
