class Flat < ApplicationRecord
  has_many :users
  has_many :rooms
  geocoded_by :address
  after_validation :geocode
end
