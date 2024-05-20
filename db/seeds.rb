# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Movie.delete_all
User.delete_all
Review.delete_all
MovieReview.delete_all



100.times do
  Movie.create!(
    title: Faker::Movie.title,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    year: Faker::Number.between(from: 1900, to: 2024),
    director: Faker::Name.name,
    filming_location: Faker::Address.city,
    country: Faker::Address.country,
    actors: Array.new(3) { Faker::Name.name }
  )
end

puts "Created 100 movies"


50.times do
  User.create!(
    username: Faker::Internet.username,
    password: "123", # So its easier to test 
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

puts "Created 50 users"


300.times do
  Review.create!(
    movie_id: Movie.all.sample.id,
    user_id: User.all.sample.id,
    rating: rand(1..5).to_i,
    review: Faker::Lorem.sentence(word_count: 10)
  )
end

puts "Created 50 reviews"


Review.all.each do |review|
  MovieReview.create!(
    movie_id: Movie.all.sample.id,
    review_id: review.id
  )
end

puts "Created 50 Movie Reviews"

