class Request < ApplicationRecord
  belongs_to :user
  belongs_to :viewing
  has_one :chat_room

  enum status: [ :pending, :accepted]

end
