class Viewing < ApplicationRecord
  belongs_to :room
  belongs_to :request
end
