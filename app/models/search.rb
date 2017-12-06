class Search
  include ActiveModel::Model
  attr_accessor :city, :move_in_date, :move_out_date, :lat, :lng, :neighborhood, :number_of_flatmates, :furnished, :monthly_price, :bills_included, :ensuite, :accessible, :allow_students, :allow_pets, :couples_allowed, :allow_smokers
  validates :city, presence: { message: "City needed" }
  # validates :move_in_date, presence: { message: "Date needed" }
end
