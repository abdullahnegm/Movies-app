module Api
  module V1
    class ActorsController < ApplicationController

      def index
        actors = Movie.search_actors_by_pattern(search_text, limit, offset)
        render_success('actors', actors, :ok)
      end

    end
  end
end