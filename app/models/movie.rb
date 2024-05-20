class Movie < ApplicationRecord
  has_many :reviews


  scope :search, -> (search_text) {
    where("title ILIKE :search OR description ILIKE :search", search: "%#{search_text}%")
  }

  scope :with_average_rating, -> {
    select('movies.*, AVG(reviews.rating) AS average_rating')
      .joins(:reviews)
      .group('movies.id')
  }

  scope :ordered_by_average_rating, -> {
    order('average_rating DESC')
  }

  def self.search_actors_by_pattern(pattern, limit, offset)
    query = <<-SQL
      WITH unnest_actors AS (
        SELECT unnest(actors) AS actor
        FROM movies
      )
      SELECT DISTINCT actor
      FROM unnest_actors
      WHERE actor ILIKE ?
      LIMIT ?
      OFFSET ?
    SQL

    result = ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.send(:sanitize_sql_array, [query, "%#{pattern}%", limit, offset])
    )

    result.map { |row| row['actor'] }
  end

end
