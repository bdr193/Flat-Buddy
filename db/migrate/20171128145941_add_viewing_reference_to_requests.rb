class AddViewingReferenceToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :viewing, foreign_key: true
  end
end
