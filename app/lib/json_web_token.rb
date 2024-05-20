class JsonWebToken
  # secret to encode and decode token
  # should be in secrets or env file, but will keep it simple for now
  HMAC_SECRET = "SECRET_KEY"

  def self.encode(payload, exp = 100.years.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(body)
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise(ErrorHandler::AuthenticationError, "Suspicious token, Authorization failed!")
  end
end