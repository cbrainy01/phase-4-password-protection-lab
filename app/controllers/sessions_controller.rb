class SessionsController < ApplicationController
    
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: 201
        else
            render json: { error: "Authentication failed" }, status: :unauthorized
        end

    end

    def destroy
        # user = User.find_by(id: session[:user_id])
        # user
        session[:user_id] = nil
        head :no_content
    end

end
