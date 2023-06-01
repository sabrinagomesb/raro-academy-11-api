class JsonWebToken
  def self.encode(payload)
    expiration = 6.hours.from_now.to_i
    JWT.encode payload.merge(exp: expiration), Rails.application.credentials.fetch(:jwt_secret_key)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.fetch(:jwt_secret_key)).first
  end
end