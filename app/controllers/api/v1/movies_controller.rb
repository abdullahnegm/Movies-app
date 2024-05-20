module Api
  module V1
    class MoviesController < ApplicationController

      def index
        movies = Movie.search(search_text).with_average_rating.ordered_by_average_rating.limit(limit).offset(offset)
        render_success('movies', movies, :ok)
      end

    end
  end
end