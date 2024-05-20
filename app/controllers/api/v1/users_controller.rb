module Api
  module V1
    class UsersController < Api::V1::ApplicationController

      def index
        render_success('movies', User.all.map { |user| Users::IndexPresenter.new(user).as_json }, :ok)
      end

    end
  end
end