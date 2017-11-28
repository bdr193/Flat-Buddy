class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.date :move_in_date
      t.date :move_out_date
      t.integer :monthly_price
      t.references :flat, foreign_key: true

      t.timestamps
    end
  end
end
