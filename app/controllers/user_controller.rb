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

    def show
        if current_user
            render json: current_user, staus: :ok
        else
            render json: { error: "Not logged in." }, status: :unauthorized
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def current_user
        # 最初にcurrent_userが呼び出されたとき、ユーザーのデータが@current_userに保存される。
        # 以降、保存された値が使用され、不要なデータベースへのクエリが省略される。
        # @current_user ||= ... は、@current_userが未定義またはnilの場合にのみ右側の式を評価する。
        # session[:user_id]が存在する場合に、User.findによってデータベースからユーザー情報を取得する。
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end 
