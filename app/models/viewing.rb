class Viewing < ApplicationRecord
  belongs_to :room
  has_one :request

  def format_date
    start_time.strftime("%l:%M %P -  %A %eth %B")
  end
end
