class Room < ApplicationRecord
  belongs_to :flat
  has_many :viewings
end
