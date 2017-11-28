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

      t.timestamps
    end
  end
end
