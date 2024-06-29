class UsersController < ApplicationController
    include UserToken
    def create
        user = User.create(user_params)
        if user.save!
            token = user.generate_jwt
            render json: {success: true, token: token}
        else
            render json: {errors: user.errors}
        end
    end

    def authenticate_user
        @decoded = User.decode_jwt(token)
        @user = User.find(@decoded['id'])
        if user
            render json: {success: true, user: user}
        else
            render json: {errors: user.errors}, status: unauthorized
        end   
    end

    def follow
        #we can imporve this
        follower = @user.followers.create(follower_id: user_id)
        if follower.save!
            render json: {success: true, followers_list: @user.followers}
        else
            render json: {errors: follower.errors}
        end   
    end

    def unfollow
        follower = @user.followers.where(follower_id: params[:user_id])
        if follower.destroy
            render json: {success: true, followers_list: User.followers}
        else
            render json: {errors: follower.errors}
        end   
    end

    private

    def user_params
        params.permit(User.require([:name, :email]))
    end
end
