class Request < ApplicationRecord
  belongs_to :user
  belongs_to :viewing

  enum status: [ :pending, :accepted]

end
