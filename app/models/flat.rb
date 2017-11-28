class Flat < ApplicationRecord
  has_many :users
  has_many :rooms
  has_attachments :photos, maximum: 10
end
