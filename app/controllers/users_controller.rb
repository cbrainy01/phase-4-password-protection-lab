class UsersController < ApplicationController

    def create
       user = User.new(user_params)
    #    byebug
        if user.password == user.password_confirmation
            user.save
            session[:user_id] = user.id
            render json: user, status: 201
        else 
            render json: { error: "passwords do not match" }, status: 422
        end
        
    end

    def show
        user = User.find_by(id: session[:user_id])
        # byebug
        if user
            session[:user_id] = user.id
            render json: {  username: user.username, id: user.id  }, status: 200
        else
            render json: { error: "unauthorized" }, status: 401
        end
    end

    private

    def user_params
        params.permit(:password, :username, :password_confirmation)
    end

end
