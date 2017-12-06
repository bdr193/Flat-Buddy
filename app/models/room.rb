class Room < ApplicationRecord
  belongs_to :flat
  has_many :viewings

  def shared_interests(user)
    buddy = flat.users.last
    if buddy.nil?
      interests = []
    else
      renter = user.attributes.select{ |k,v| v.to_s == "true" }
      owner = buddy.attributes.select{ |k,v| v.to_s == "true" }
      merge = renter.to_a & owner.to_a
      interest_array = merge.flatten
      p renter
      p owner
      p merge
      p interest_array
      interests = []
      x = 2
      interest_array.each_index do |index|
        if index % x == 0
          interests << interest_array[index]
        end
      end
    end
    return interests
  end

end
