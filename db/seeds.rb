require 'json'
require 'open-uri'
require_relative 'urls'
require "yaml"


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

def analyze_room_db(room_db_string, title)
  room = JSON.parse(room_db_string)
  raw_urls = room["photos"]
  urls = []
  unless raw_urls.nil?
    raw_urls.each do |raw_url|
      url = "https://kangaroom.azureedge.net/photos-medium/#{raw_url["guid"]}"
      urls << url
    end
  end

  flat_attr = {
    title: title,
    monthly_price: room["price"].to_i,
    description: room["description"],
    number_of_flatmates: rand(1..3),
    flat_size: rand(70..125),
    amenities: AMENITIES.sample(6).join(','),
    neighborhood: room["place"],
    currency: room["currency"],
    lat: room["latitude"],
    lng: room["longitude"],
    room_size: rand(12..30),
    has_parking: room["hasParking"] == 'true' ,
    deposit: room["deposit"].to_i,
    allow_students: room["allowStudents"] == 'true',
    allow_pets: room["allowPets"] == 'true',
    allow_smokers: room["allowSmokers"].to_i,
    bills_included: room["billsIncluded"].to_i,
    furnished: room["furnished"].to_i,
    couples_allowed: room["allowCouples"] == 'true',
    ensuite: room["ensuite"] == 'true',
    accessible: room["accessible"] == 'true',
    minimum_stay: room["minimumStay"].to_i,
    preffered_min_age: room["preferredMinAge"].to_i,
    preffered_max_age: room["preferredMaxAge"].to_i,
    preffered_gender: room["preferredGender"].to_i,
    searching_for: room["preferredRoommateDescription"],
    card_image: room["thumbnailImageUrl"],
    photo_urls: urls
  }

  room_atr = {
    move_in_date: DateTime.parse(room["availableDate"]),
    # flat_id: flat.id
  }

  return flat_attr, room_atr
end

def scrape_room(room_url)
  url = "https://kangaroom.com/#{room_url}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  title = ''
  html_doc.xpath("//meta[@property='og:title']/@content").each do |attr|
    title = attr.value[0..-12]
  end
  html_doc.css('script').each do |script|
    all_scripts = script.content
    scripts_split = all_scripts.split("obj.room =")
    unless scripts_split[1].nil?
      room_db = scripts_split[1].split("};")[0]
      room_db_fixed = room_db + '}'
      flat, room = analyze_room_db(room_db_fixed, title)
      return flat, room
    end
  end
end


def checking_urls
  flats = []
  rooms = []
  Urls.get_urls.each_with_index do |room_url, index|
    flat, room = scrape_room(room_url)
    flats << flat
    rooms << room
    puts "Created #{index + 1} flats and Rooms"
  end

  puts "Saving flats to YML"
  File.open("/Users/rabeabader/code/bdr193/Flat-Buddy/db/flats_info.yml", "r+") do |f|
    f.write(flats.to_yaml)
  end

  puts "Saving rooms to YML"
  File.open("/Users/rabeabader/code/bdr193/Flat-Buddy/db/rooms_info.yml", "r+") do |f|
    f.write(rooms.to_yaml)
  end

end

puts "Creating users"

def create_users
  users = []
  100.times do |counter|
    user = JSON.load(open("https://uinames.com/api/?ext"))
    begin
      user_attr = {
        email: user["email"],
        password: user["password"],
        first_name: user["name"],
        last_name: user["surname"],
        facebook_picture_url: user["photo"],
        # flat_id: Flat.all[counter][:id]
      }
      users << user_attr
    rescue ActiveRecord::RecordInvalid => invalid
      puts invalid.record.errors.messages
    end
    puts "Creating user # #{counter}"
  end
  puts "Saving users to YML"
  File.open("/Users/rabeabader/code/bdr193/Flat-Buddy/db/users_info.yml", "r+") do |f|
    f.write(users.to_yaml)
  end
end

puts "Users created"

checking_urls
create_users

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
