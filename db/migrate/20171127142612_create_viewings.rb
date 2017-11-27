class CreateViewings < ActiveRecord::Migration[5.0]
  def change
    create_table :viewings do |t|
      t.datetime :start_time
      t.integer :duration
      t.references :room, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
