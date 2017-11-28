class RemoveRequestReferenceFromViewing < ActiveRecord::Migration[5.0]
  def change
    remove_reference :viewings, :request, foreign_key: true
  end
end
