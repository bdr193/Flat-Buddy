class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.date :move_in_date
      t.date :move_out_date
      t.text :searching_for
      t.integer :monthly_price
      t.integer :room_size
      t.integer :deposit
      t.boolean :has_parking
      t.boolean :allow_students
      t.boolean :allow_pets
      t.integer :bills_included
      t.integer :allow_smokers
      t.integer :furnished
      t.boolean :copplues_allowd
      t.boolean :ensuite
      t.boolean :accessible
      t.integer :minimum_stay
      t.integer :preffered_min_age
      t.integer :preffered_max_age
      t.integer :preffered_gender
      t.references :flat, foreign_key: true
      t.timestamps
    end
  end
end
