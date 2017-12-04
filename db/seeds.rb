require 'json'
require 'open-uri'
require "yaml"


# Users need to have a flat ID
# Profiles and interests

AMENITIES = ["Wifi", "TV", "Elevator", "Doorman", "Washer", "Dryer", "Gym", "Iron", "Kitchen", "Hot tub", "Air conditioning", "Heating"]
puts "Clearing database"
puts "Clearing rooms"
Room.destroy_all
puts "Clearing flats"
Flat.destroy_all
puts "Clearing users"
User.destroy_all


def create_request(viewing)
  request = Request.new(
    slot: Time.strptime('28/12/2017 19:00', '%d/%m/%Y %H:%M') + rand(2..20).to_i.day,
    user_id: 1,
    viewing_id: viewing.id,
  )

  status = rand(0..1).to_i
  case status
  when 0
    request.accepted!
  when 1
    request.pending!
  end
  request.save!
end

def create_viewing(room)
  vi = viewing_one = Viewing.new(
    start_time: room.created_at + 1.day,
    duration: 45,
    room_id: room.id
  )
  vi.save
  create_request(vi) if rand(0..7).to_i == 1
end

def create_room(flat, room)
  puts flat.id
  begin
    room[:flat_id] = flat.id
  rescue Exception => e
    puts e.message
  end
  ro = Room.new(room)
  ro.save
  create_viewing(ro)
end

def create_flats_and_rooms
  flats = YAML::load_file(File.join(__dir__, 'flats_info.yml'))
  rooms = YAML::load_file(File.join(__dir__, 'rooms_info.yml'))
  flats.each_with_index do |flat, index|
    flat[:photo_urls] = []
    puts "Creating flat #{index}"
    fl = Flat.new(flat)
    fl.save
    puts "Creating a room for the flat"
    create_room(fl, rooms[index])
  end
end

def create_users
  users = YAML::load_file(File.join(__dir__, 'users_info.yml'))
  users.each_with_index do |user, index|
    puts "Creating user #{index}"
    begin
      User.create!(user)
    rescue Exception => e
      puts e.message
      puts "The error is in#{user[:email]}"
    end

  end
end

user_one = User.create!(
  email: "rabea_bader@gmail.com",
  password: "secret123",
  first_name: "Rabea",
  last_name: "Badea",
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/11267855_494475644050145_7650517800177078839_n.jpg?oh=88f598f1fc8228a3a81f204d69ab47bb&oe=5A916072"
)

create_flats_and_rooms
create_users




# request_one = Request.create!(
#   slot: Time.strptime('28/11/2017 19:00', '%d/%m/%Y %H:%M'),
#   user_id: 1,
#   viewing_id: 1,
# )
# request_one.accepted!
# request_one.save!

# puts "Request 1 created"
#
# request_two = Request.create!(
#   slot: Time.strptime('29/11/2017 19:00', '%d/%m/%Y %H:%M'),
#   user_id: 1,
#   viewing_id: 2,
#   )
# request_two.pending!
# request_two.save!
#
# puts "Request 2 created"
#
# #
# flat_attr = {
#   title: title,
#   monthly_price: room["price"].to_i,
#   description: room["description"],
#   number_of_flatmates: rand(1..3),
#   flat_size: rand(70..125),
#   amenities: AMENITIES.sample(6).join(','),
#   neighborhood: room["place"],
#   currency: room["currency"],
#   lat: room["latitude"],
#   lng: room["longitude"],
#   room_size: rand(12..30),
#   has_parking: room["hasParking"] == 'true' ,
#   deposit: room["deposit"].to_i,
#   allow_students: room["allowStudents"] == 'true',
#   allow_pets: room["allowPets"] == 'true',
#   allow_smokers: room["allowSmokers"].to_i,
#   bills_included: room["billsIncluded"].to_i,
#   furnished: room["furnished"].to_i,
#   couples_allowed: room["allowCouples"] == 'true',
#   ensuite: room["ensuite"] == 'true',
#   accessible: room["accessible"] == 'true',
#   minimum_stay: room["minimumStay"].to_i,
#   preffered_min_age: room["preferredMinAge"].to_i,
#   preffered_max_age: room["preferredMaxAge"].to_i,
#   preffered_gender: room["preferredGender"].to_i,
#   searching_for: room["preferredRoommateDescription"],
#   card_image: room["thumbnailImageUrl"],
#   photo_urls: urls
# }
#
# room_atr = {
#   move_in_date: DateTime.parse(room["availableDate"]),
#   # flat_id: flat.id
# }
#
#
#
#
# puts "Users created"



# def analyze_flats_db(data_base)
#   room_urls = []
#   # JSONifying the flats object from string
#   db_json = JSON.parse(data_base).map(&:with_indifferent_access)
#   db_json.each do |apt|
#     # getting the apartment url of each flat and scraping the apartment
#     room_urls << apt[:url]
#     # scrape_room(apt[:url])
#   end
#   p room_urls
#   raise
# end
#
# # Reading Kangaroom url, apartments only in london
# url = 'https://kangaroom.com/room/search?exp=London&lat=51.5073509&lon=-0.12775829999998223&countryId=76'
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)
#
# # The html_doc contains objects of all the flats in london
# html_doc.css('script').each do |script|
#   all_scripts = script.content
#   scripts_split = all_scripts.split("obj.rooms =")
#   unless scripts_split[1].nil?
#     # Separating the flats string object from other scripts
#     database_string = scripts_split[1].split(";")[0]
#     analyze_flats_db(database_string)
#   end
# end
