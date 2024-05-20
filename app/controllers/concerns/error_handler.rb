module ErrorHandler
  extend ActiveSupport::Concern

  ################### Custom Error Subclasses ####################
  class AuthenticationError < StandardError; end

  included do
    ####################### Custom Handlers ########################
    rescue_from ErrorHandler::AuthenticationError, with: :unauthorized_request

    # Catch record not found exception
    rescue_from ActiveRecord::RecordNotFound do |err|
      render(
        json: { success: false, message: err.message },
        status: :not_found
      )
    end

    # Catch invalid record exception
    rescue_from ActiveRecord::RecordInvalid do |err|
      error_message = err.message&.split(": ")
      render(
        json: { success: false, message: error_message[1] },
        status: :bad_request
      )
    end

  end

  private

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(err)
      render(
      json: { success: false, message: err.message },
      status: :unauthorized
      )
  end
end