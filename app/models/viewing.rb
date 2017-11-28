class Viewing < ApplicationRecord
  belongs_to :room
  has_one :request
end
