class Search
  include ActiveModel::Model
  attr_accessor :city, :move_in_date, :move_out_date, :lat, :lng
  validates :city, presence: { message: "City needed" }
  validates :move_in_date, presence: { message: "Date needed" }
end
