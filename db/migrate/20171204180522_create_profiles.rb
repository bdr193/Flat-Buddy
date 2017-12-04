class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.boolean :art_museum
      t.boolean :art_photography
      t.boolean :art_theatre
      t.boolean :art_live
      t.boolean :art_cinema
      t.boolean :art_reading
      t.boolean :sport_ball
      t.boolean :sport_endurance
      t.boolean :sport_wellbeing
      t.boolean :sport_snow
      t.boolean :sport_extreme
      t.boolean :sport_watersports
      t.boolean :film_romcom
      t.boolean :film_action
      t.boolean :film_horror
      t.boolean :film_documentary
      t.boolean :film_animation
      t.boolean :film_scifi
      t.boolean :music_pop
      t.boolean :music_electronic
      t.boolean :music_classical
      t.boolean :music_rock
      t.boolean :music_jazz
      t.boolean :music_hiphop
      t.boolean :holiday_beach
      t.boolean :holiday_trek
      t.boolean :holiday_city
      t.boolean :holiday_party
      t.boolean :holiday_home
      t.boolean :holiday_historic
      t.boolean :food_vegetarian
      t.boolean :food_meat
      t.boolean :food_quick
      t.boolean :food_restaurant
      t.boolean :food_delivery
      t.boolean :food_drink

      t.timestamps
    end
  end
end
