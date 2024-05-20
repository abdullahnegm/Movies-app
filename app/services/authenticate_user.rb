class AuthenticateUser
  def initialize(**args)
    @username = args[:username]
    @password = args[:password]
  end

  def call
    return unless user

    JsonWebToken.encode(user_id: user.id)
  end

  private

  attr_reader :username, :password

  # Authenticate the user with username if exists
  def user
    user = User.find_by_username(username)
    return user if user.present?
    
    # raise Authentication error if credentials are invalid
    raise(ErrorHandler::AuthenticationError, 'You have either entered a wrong Username or password')
  end
end