module Api
  module V1
    class ApplicationController < ActionController::Base

      include ErrorHandler
      include ResponseHandler
      
      # skip_before_action :verify_authenticity_token
      # before_action :authenticate_request

      def authenticate_request
        @current_user = AuthorizeApiRequest.new(headers: request.headers).call
        return render_error('Token expired, Authorization failed!', :unauthorized) if @current_user.nil?
    
        @current_user
      end

      def search_text
        params[:search] || ""
      end

      def limit
        params[:limit] || 10
      end

      def offset
        params[:offset] || 0
      end

    end
  end
end
