class ApplicationController < ActionController::Base
    before_action: authenticate_user

    private

    def authenticate_user
        @decoded = User.decode_jwt(token)
        @user = User.find(@decoded['id'])
    
        render json: { error: 'Invalid authenticity token' }, status: :unauthorized unless @user
        end
    end
end
