class UserController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def create
        user = User.new(user_params)
        if user.save
            render json: user, status: :created
        else
            render json: user.errors, status: :unpocessable_entity
        end
    end

    def login
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: { message: "Logged in successfully.", user_id: user.id }, status: :ok
        else
            render json: { message: "Invalid email or password" }, status: :unauthorized
        end
    end    

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end 
