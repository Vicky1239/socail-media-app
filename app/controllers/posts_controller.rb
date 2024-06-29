class PostsController < ApplicationController
    before_action: [:edit, :update, :destroy, :like, :comment], :load_post
    
    def create
        post = @user.posts.create(post_params)
        if post.save!
            render json: {success: true, }
        else
            render json: {errors: post.errors}
        end
    end

    def update
        if @post.update(post_params)
            render json: {success: true, message: "user updated successfully"}
        else
            render json: {errors: @post.errors}
        end
    end

    def destroy
        if @post.destroy
            render json: {success: true, message: "user destroyed successfully"}
        else
            render json: {errors: @post.errors}
        end 
    end

    def like
        @like = @post.likes.create(user: @user)
        if @like
            render json: {success: true, total_likes: @post.likes.where(user: @user.count)}
        else
            render json: {errors: @like.errors}
        end 
    end

    def comment
        @comment = @post.comments.create(user: @user)
        if @comment
            render json: {success: true, total_likes: @post.comments.where(user: @user.count)}
        else
            render json: {errors: @comment.errors}
        end
    end

    private

    def post_params
        params.permit(Post.require([:description, :title]))
    end

    def load_post
        @post = Post.find_by(id: params[:id])
    end

end
