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
  # create_request(vi) if rand(0..7).to_i == 1
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


#START OF DATA FOR DEMO DAY!!!

flat_one = Flat.create!(
  title: "Le Wagon Dreamteam",
  description: "We all met at Le Wagon Berlin in 2017 and decided to bring our cool platform FlatBuddy to London. How could we better represent our idea than moving in together? Of course our choice fell to Shoreditch. We are all Hipsters, out of money and love to drink! The connection is super good with the Underground just around the corner. The neighborhood is tidy, not the calmest though with all the party people around. Supermarket, bank and gym just nearby.",
  number_of_flatmates: 3,
  flat_size: 100,
  amenities: "Wifi, TV, Elevator, Doorman, Washer, Dryer, Iron, Air conditioning",
  address: "11 Hoxton Square, London N1 6NU",
  currency: "£",
  neighborhood: "Shoreditch",
   searching_for: nil,
   monthly_price: 540,
   room_size: 20,
   card_image: '/assets/lewagonflat.jpg',
   deposit: 600,
   has_parking: nil,
   allow_students: false,
   allow_pets: false,
   bills_included: 1,
   allow_smokers: 0,
   furnished: 2,
   couples_allowed: false,
   ensuite: false,
   accessible: false,
   minimum_stay: 6,
   preffered_min_age: 20,
   preffered_max_age: 30,
   preffered_gender: nil,
   latitude: 51.528001,
   longitude: -0.081881
  )

  puts "Flat 1"

user_one = User.create!(
  email: "rabea_bader@gmail.com",
  password: "secret123",
  first_name: "Rabea",
  last_name: "Badea",
  art_museum: true,
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/11267855_494475644050145_7650517800177078839_n.jpg?oh=88f598f1fc8228a3a81f204d69ab47bb&oe=5A916072"
)

puts "User 1"

user_two = User.create!(
  email: "sarah_lafer@yahoo.com",
  password: "secret123",
  first_name: "Sarah",
  last_name: "Lafer",
  art_museum: true,
  sport_endurance: true,
  film_animation: true,
  music_jazz: true,
  holiday_home: true,
  food_delivery: true,
  flat_id: 1,
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t31.0-8/15123387_1524489700911298_8540080221667972968_o.jpg?oh=81c74c24d54e1d3f4989184e7a9ee45a&oe=5AA0CACD"
)

puts "User 2"

user_three = User.create!(
  email: "stephan_is_great@gmail.com",
  password: "secret123",
  first_name: "Stephan",
  last_name: "Schmidbauer",
  flat_id: 1,
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/12472516_1150297835028069_8300065499297260894_n.jpg?oh=61fd7f780e66b7d600be2918c009e714&oe=5AA8DD43"
)

puts "User 3"

user_four = User.create!(
  email: "richard_ogrady@gmail.com",
  password: "secret123",
  first_name: "Richard",
  last_name: "O'Grady",
  flat_id: 1,
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t31.0-8/15972751_237246466721822_1634594414421206870_o.jpg?oh=51c4df723a1a2e64c7972c3e34468b0b&oe=5A8F41B5"
)

puts "User 4"

#ALL OTHER USERS AND FLATS AND ROOMS

room_one = Room.create!(
  move_in_date: '01/01/2018',
  flat_id: 1
  )
create_flats_and_rooms
create_users


viewing_one = Viewing.create!(
  start_time: Time.strptime('11/12/2017 19:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 1,
  )

viewing_two = Viewing.create!(
  start_time: Time.strptime('12/12/2017 20:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 1,
  )

viewing_three = Viewing.create!(
  start_time: Time.strptime('13/12/2017 18:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 1,
  )

viewing_four = Viewing.create!(
  start_time: Time.strptime('13/12/2017 19:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 1,
  )

viewing_five = Viewing.create!(
  start_time: Time.strptime('14/12/2017 20:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 1,
  )

viewing_six = Viewing.create!(
  start_time: Time.strptime('11/12/2017 19:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 10,
  )

viewing_seven = Viewing.create!(
  start_time: Time.strptime('12/12/2017 19:30', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 11,
  )

viewing_eight = Viewing.create!(
  start_time: Time.strptime('14/12/2017 20:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 12,
  )

viewing_nine = Viewing.create!(
  start_time: Time.strptime('12/12/2017 18:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 13,
  )

viewing_ten = Viewing.create!(
  start_time: Time.strptime('15/12/2017 21:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room_id: 14,
  )


request_one = Request.create!(
  slot: Time.strptime('11/12/2017 19:00', '%d/%m/%Y %H:%M'),
  user_id: 1,
  viewing_id: 6,
)
request_one.accepted!
request_one.save!

puts "Request 1 created"

request_two = Request.create!(
  slot: Time.strptime('12/12/2017 19:30', '%d/%m/%Y %H:%M'),
  user_id: 1,
  viewing_id: 7,
  )
request_two.accepted!
request_two.save!

puts "Request 2 created"

request_three = Request.create!(
  slot: Time.strptime('14/12/2017 20:00', '%d/%m/%Y %H:%M'),
  user_id: 1,
  viewing_id: 8,
  )
request_three.accepted!
request_three.save!

puts "Request 3 created"

request_four = Request.create!(
  slot: Time.strptime('12/12/2017 18:00', '%d/%m/%Y %H:%M'),
  user_id: 1,
  viewing_id: 9,
  )
request_four.pending!
request_four.save!

puts "Request 4 created"

request_five = Request.create!(
  slot: Time.strptime('15/12/2017 21:00', '%d/%m/%Y %H:%M'),
  user_id: 1,
  viewing_id: 10,
  )
request_five.pending!
request_five.save!

puts "Request 5 created"

chat_room_one = ChatRoom.create!(
  request_id: 1
  )

puts "Chatroom 1 created"

chat_room_two = ChatRoom.create!(
  request_id: 2
  )

puts "Chatroom 2 created"

chat_room_three = ChatRoom.create!(
  request_id: 3
  )

puts "Chatroom 3 created"


message_one = Message.create!(
  user_id: 20,
  content: "Hi Rich, looking forward to meet you next week. Any questions beforehand, please let me know.",
  chat_room_id: 1
  )

puts "Message 1 created"


message_two = Message.create!(
  user_id: 30,
  content: "Yo Rich, u comin next week still up to date?",
  chat_room_id: 2
  )

puts "Message 2 created"

message_three = Message.create!(
  user_id: 40,
  content: "Looking forward to seeing you next week Rich!",
  chat_room_id: 3
  )

puts "Message 3 created"



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
