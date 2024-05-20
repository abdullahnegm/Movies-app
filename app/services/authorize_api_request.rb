class AuthorizeApiRequest
  def initialize(**args)
    @headers = args[:headers]
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
      begin
        User.find(decoded_auth_token[:user_id])
      rescue ActiveRecord::RecordNotFound
          raise(ErrorHandler::AuthenticationError, "Invalid credentials")
      end
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    raise(ErrorHandler::MissingToken, "Missing token in the sent header!")
    # here to rescue any locale is not english
  rescue I18n::InvalidLocale
    raise(ErrorHandler::AuthenticationError, "Invalid credentials")
  end
end