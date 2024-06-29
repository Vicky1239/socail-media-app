class User < ApplicationRecord
    has_many: posts
    has_many: likes
    has_many: followers, through: User
    has_secure_password

    def generate_jwt
        JWT.encode({ id: id, exp: 15.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
    end

    def self.decode_jwt(token)
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        User.find(decoded_token['id'])
    rescue JWT::DecodeError
        nil
    end
end
