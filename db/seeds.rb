require 'json'
require 'open-uri'
require_relative 'urls'


# Users need to have a flat ID
# Profiles and interests

AMENITIES = ["Wifi", "TV", "Elevator", "Doorman", "Washer", "Dryer", "Gym", "Iron", "Kitchen", "Hot tub", "Air conditioning", "Heating"]

puts "Clearing database"

puts "Clearing users"
User.destroy_all
puts "Clearing flats"
Flat.destroy_all
puts "Clearing rooms"
Room.destroy_all
puts "Clearing requests"
Request.destroy_all
puts "Clearing Viewings"
Viewing.destroy_all

puts "Creating users"

user_one = User.create!(
  email: "rabea_bader@gmail.com",
  password: "secret123",
  first_name: "Rabea",
  last_name: "Badea",
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/11267855_494475644050145_7650517800177078839_n.jpg?oh=88f598f1fc8228a3a81f204d69ab47bb&oe=5A916072"
)

user_two = User.create!(
  email: "sarah_lafer@yahoo.com",
  password: "secret123",
  first_name: "Sarah",
  last_name: "Lafer",
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t31.0-8/15123387_1524489700911298_8540080221667972968_o.jpg?oh=81c74c24d54e1d3f4989184e7a9ee45a&oe=5AA0CACD"
)

user_three = User.create!(
  email: "stephan_is_great@gmail.com",
  password: "secret123",
  first_name: "Stephan",
  last_name: "Schmidbauer",
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/12472516_1150297835028069_8300065499297260894_n.jpg?oh=61fd7f780e66b7d600be2918c009e714&oe=5AA8DD43"
)

user_four = User.create!(
  email: "richard_ogrady@gmail.com",
  password: "secret123",
  first_name: "Richard",
  last_name: "O'Grady",
  facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t31.0-8/15972751_237246466721822_1634594414421206870_o.jpg?oh=51c4df723a1a2e64c7972c3e34468b0b&oe=5A8F41B5"
)

user_five = User.create!(
  email: "david_beckham@hotmail.com",
  password: "secret123",
  first_name: "David",
  last_name: "Beckham",
  facebook_picture_url: "https://www.famousbirthdays.com/headshots/david-beckham-4.jpg"
)

users = [user_one, user_two, user_three, user_four, user_five]

puts "Users created"

def analyze_room_db(room_db_string)
  room = JSON.parse(room_db_string)
  flat = Flat.create!(
    # title: flat_attr[:title],
    description: room["description"],
    number_of_flatmates: rand(1..3),
    flat_size: rand(70..125),
    amenities: 'Wifi',
    neighborhood: room["place"],
    currency: room["currency"],
    lat: room["latitude"],
    lng: room["longitude"]
  )

  Room.create!(
    # move_in_date: Date.new(room["availableDate"]),
    monthly_price: room["price"].to_i,
    room_size: rand(12..30),
    has_parking: room["hasParking"] == 'true' ,
    deposit: room["deposit"].to_i,
    allow_students: room["allowStudents"] == 'true',
    allow_pets: room["allowPets"] == 'true',
    allow_smokers: room["allowSmokers"].to_i,
    bills_included: room["billsIncluded"].to_i,
    furnished: room["furnished"].to_i,
    copplues_allowd: room["allowCouples"] == 'true',
    ensuite: room["ensuite"] == 'true',
    accessible: room["accessible"] == 'true',
    minimum_stay: room["minimumStay"].to_i,
    preffered_min_age: room["preferredMinAge"].to_i,
    preffered_max_age: room["preferredMaxAge"].to_i,
    preffered_gender: room["preferredGender"].to_i,
    searching_for: room["preferredRoommateDescription"],
    flat_id: flat.id
  )
end

def scrape_room(room_url)
  puts "Scraping a room #{room_url[-2]}"
  url = "https://kangaroom.com/#{room_url}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.css('script').each do |script|
    all_scripts = script.content
    scripts_split = all_scripts.split("obj.room =")

    unless scripts_split[1].nil?
      room_db = scripts_split[1].split("};")[0]
      room_db_fixed = room_db + '}'
      analyze_room_db(room_db_fixed)
    end
  end
end

Urls.get_urls.each do |room_url|
  scrape_room(room_url)
end

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





#
# flat_one_urls = [
# 'https://a0.muscache.com/im/pictures/19755676/c2d3162d_original.jpg?aki_policy=xx_large',
# 'https://a0.muscache.com/im/pictures/19755406/7d2cd964_original.jpg?aki_policy=x_large',
# 'https://a0.muscache.com/im/pictures/19754957/12890c27_original.jpg?aki_policy=x_large',
# 'https://a0.muscache.com/im/pictures/19755883/ff9db51b_original.jpg?aki_policy=x_large',
# 'https://a0.muscache.com/im/pictures/19755968/b3e4b8e9_original.jpg?aki_policy=x_large',
# 'https://a0.muscache.com/im/pictures/19755768/95112653_original.jpg?aki_policy=x_large'
# ]
#
# flat_one = Flat.create!(
#   title: "Flatshare - We're lovin it!",
#   description: "This large & modern penthouse is in a great, central area & consists of 3 floors, all boasting unbelievable views. The top floor has a private plunge pool & magical 360° vistas. Situated on the slopes of Table Mountain & close to everything!",
#   monthly_price: 440,
#   number_of_flatmates: 3,
#   amenities: "Internet, Free parking, Smoking allowed",
#   address: "Axel-Springer-Straße 41, 10969 Berlin",
#   neighborhood: "Rudi-Dutschke-Straße 26, 10969 Berlin",
#   photo_urls: flat_one_urls
#   # latitude: 52.507535,
#   # longitude: 13.399219,
#   )
#
# puts "Flat 1 created"
#
# room_one = Room.create!(
#   move_in_date: '01-12-2017',
#   move_out_date: '01-05-2018',
#   flat_id: flat_one[:id],
#   )
#
# puts "Room 1 created"
#
# request_one = Request.create!(
#   slot: Time.strptime('28/11/2017 19:00', '%d/%m/%Y %H:%M'),
#   user_id: 1,
#   )
# request_one.accepted!
# request_one.save!
#
# puts "Request 1 created"
#
# viewing_one = Viewing.create!(
#   start_time: Time.strptime('28/11/2017 19:00', '%d/%m/%Y %H:%M'),
#   duration: 45,
#   room_id: 1,
#   )
#
# puts "Viewing 1 created"
