module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate_request, only: [:index] # This API is for testing, to get a username and the password is fixed anyway

      def index
        render_success('movies', User.all.map { |user| Users::IndexPresenter.new(user).as_json }, :ok)
      end

    end
  end
end