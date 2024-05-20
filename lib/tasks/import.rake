namespace :import do
  desc "Import from CSV file"

  task movies: :environment do
    require 'csv'
    require 'activerecord-import/base'
    require 'activerecord-import/active_record/adapters/postgresql_adapter'

    file_path = 'public/movies.csv' 
    batch_size = 1000

    movies_hash = {}

    CSV.foreach(file_path, headers: true) do |row|
      title = row['Movie']
      actors = row['Actor']
      filming_location = row['Filming location']

      movies_hash["#{title}-#{filming_location}"] ||= {
        title: title,
        description: row['Description'],
        year: row['Year'].to_i,
        director: row['Director'],
        filming_location: row['Filming location'],
        country: row['Country'],
        actors: []
      }

      movies_hash["#{title}-#{filming_location}"][:actors] << actors
    end

    movies = []

    movies_hash.each_value do |movie|
      movies << Movie.new(
        title: movie[:title],
        description: movie[:description],
        year: movie[:year],
        director: movie[:director],
        filming_location: movie[:filming_location],
        country: movie[:country],
        actors: movie[:actors].uniq # Remove duplicate actors
      )

      if movies.size >= batch_size
        Movie.import movies
        movies.clear
      end
    end

    Movie.import movies unless movies.empty?

    puts 'Import finished.'
  end

  task reviews: :environment do
    require 'csv'
    require 'activerecord-import/base'
    require 'activerecord-import/active_record/adapters/postgresql_adapter'

    file_path = 'public/reviews.csv' # Update with the actual path to your CSV file
    batch_size = 1000

    # Load all movies into a hash for quick lookup
    movies = Movie.all.index_by(&:title)
    # Load all users into a hash for quick lookup
    users = User.all.index_by(&:name)

    reviews = []

    CSV.foreach(file_path, headers: false) do |row|
      movie_title, user_name, rating, review = row
      movie = movies[movie_title]
      user = users[user_name]
      if movie
        reviews << Review.new(
          movie_id: movie.id,
          user_id: user&.id, # Use user id if user exists
          rating: rating.to_i,
          review: review
        )

        if reviews.size >= batch_size
          Review.import reviews
          reviews.clear
        end
      else
        puts "Movie not found: #{movie_title}"
      end
    end

    # Import any remaining reviews
    Review.import reviews unless reviews.empty?

    puts 'Import finished.'
  end
end
