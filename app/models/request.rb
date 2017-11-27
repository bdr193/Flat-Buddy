class Request < ApplicationRecord
  belongs_to :user
  has_one :viewing

  enum status: [ :pending, :accepted]

end
