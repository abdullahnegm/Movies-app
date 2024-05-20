module Api
  module V1
    class ApplicationController < ActionController::Base

      include ErrorHandler
      include ResponseHandler
      
      # skip_before_action :verify_authenticity_token
      # before_action :authenticate_request

    end
  end
end
