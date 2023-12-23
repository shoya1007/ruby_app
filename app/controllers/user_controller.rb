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

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end 
