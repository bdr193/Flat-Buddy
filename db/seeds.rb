# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing database"

puts "Clearing requests"
Request.destroy_all
puts "Clearing Viewings"
Viewing.destroy_all
puts "Clearing rooms"
Room.destroy_all
puts "Clearing flats"
Flat.destroy_all
puts "Clearing users"
User.destroy_all

puts "Creating users"

user_one = User.new(
  email: "rabea_bader@gmail.com",
  password: "secret123",
  first_name: "Rabea",
  last_name: "Badea",
  # facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/11267855_494475644050145_7650517800177078839_n.jpg?oh=88f598f1fc8228a3a81f204d69ab47bb&oe=5A916072"
)
user_one.save

user_two = User.new(
  email: "sarah_lafer@yahoo.com",
  password: "secret123",
  first_name: "Sarah",
  last_name: "Lafer",
  # facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t31.0-8/15123387_1524489700911298_8540080221667972968_o.jpg?oh=81c74c24d54e1d3f4989184e7a9ee45a&oe=5AA0CACD"
)
user_two.save

user_three = User.new(
  email: "stephan_is_great@gmail.com",
  password: "secret123",
  first_name: "Stephan",
  last_name: "Schmidbauer",
  # facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/12472516_1150297835028069_8300065499297260894_n.jpg?oh=61fd7f780e66b7d600be2918c009e714&oe=5AA8DD43"
)
user_three.save

user_four = User.new(
  email: "richard_ogrady@gmail.com",
  password: "secret123",
  first_name: "Richard",
  last_name: "O'Grady",
  # facebook_picture_url: "https://scontent-frt3-1.xx.fbcdn.net/v/t31.0-8/15972751_237246466721822_1634594414421206870_o.jpg?oh=51c4df723a1a2e64c7972c3e34468b0b&oe=5A8F41B5"
)
user_four.save

user_five = User.new(
  email: "david_beckham@hotmail.com",
  password: "secret123",
  first_name: "David",
  last_name: "Beckham",
  # facebook_picture_url: "https://www.famousbirthdays.com/headshots/david-beckham-4.jpg"
)
user_five.save

users = [user_one, user_two, user_three, user_four, user_five]

puts "Users created"

flat_one_urls = [
'https://a0.muscache.com/im/pictures/19755676/c2d3162d_original.jpg?aki_policy=xx_large',
'https://a0.muscache.com/im/pictures/19755406/7d2cd964_original.jpg?aki_policy=x_large',
'https://a0.muscache.com/im/pictures/19754957/12890c27_original.jpg?aki_policy=x_large',
'https://a0.muscache.com/im/pictures/19755883/ff9db51b_original.jpg?aki_policy=x_large',
'https://a0.muscache.com/im/pictures/19755968/b3e4b8e9_original.jpg?aki_policy=x_large',
'https://a0.muscache.com/im/pictures/19755768/95112653_original.jpg?aki_policy=x_large'
]

flat_one = Flat.new(
  title: "Flatshare - We're lovin it!",
  description: "This large & modern penthouse is in a great, central area & consists of 3 floors, all boasting unbelievable views. The top floor has a private plunge pool & magical 360° vistas. Situated on the slopes of Table Mountain & close to everything!",
  monthly_price: 440,
  number_of_flatmates: 3,
  amenities: "Internet, Free parking, Smoking allowed",
  address: "Axel-Springer-Straße 41, 10969 Berlin",
  neighborhood: "Kreuzberg",
  photo_urls: []
  # latitude: 52.507535,
  # longitude: 13.399219,
  )

flat_one.save

puts "Flat 1 created"

room_one = Room.new(
  move_in_date: Date.parse('01-12-2017'),
  move_out_date: Date.parse('01-05-2018'),
  flat: flat_one,
  )
room_one.save
puts "Room 1 created"


viewing_one = Viewing.new(
  start_time: Time.strptime('28/11/2017 19:00', '%d/%m/%Y %H:%M'),
  duration: 45,
  room: room_one,
  )
viewing_one.save

puts "Viewing 1 created"
request_one = Request.new(
  slot: Time.strptime('28/11/2017 19:00', '%d/%m/%Y %H:%M'),
  user_id: user_one,
  viewing: viewing_one,
  )
request_one.accepted!
request_one.save!

puts "Request 1 created"
