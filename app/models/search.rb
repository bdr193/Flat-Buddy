class Search
include ActiveModel::Model
attr_accessor :city, :move_in_date, :move_out_date, :lat, :lng
validates :city, presence: true
validates :move_in_date, presence: true
end
