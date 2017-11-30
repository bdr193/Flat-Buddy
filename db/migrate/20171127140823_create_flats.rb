class CreateFlats < ActiveRecord::Migration[5.0]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :description
      t.integer :number_of_flatmates
      t.integer :flat_size
      t.text :amenities
      t.string :address
      t.string :currency
      t.string :lat
      t.string :lng
      t.string :neighborhood
      t.text :searching_for
      t.integer :monthly_price
      t.integer :room_size
      t.string :card_image
      t.integer :deposit
      t.boolean :has_parking
      t.boolean :allow_students
      t.boolean :allow_pets
      t.integer :bills_included
      t.integer :allow_smokers
      t.integer :furnished
      t.boolean :couples_allowed
      t.boolean :ensuite
      t.boolean :accessible
      t.integer :minimum_stay
      t.integer :preffered_min_age
      t.integer :preffered_max_age
      t.integer :preffered_gender
      t.timestamps
    end
  end
end
