class Flat < ApplicationRecord
  has_many :users
  has_many :rooms
  geocoded_by :address
  after_validation :geocode
  has_attachments :photos, maximum: 10
end
