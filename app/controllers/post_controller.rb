class PostController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        post = current_user.posts.build(post_params)

        if post.save
            render json: post, status: :created
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end

    def index
        posts = Post.all
        render json: posts
    end

    def show
        post = post = get_post_by_id(params[:id])
        render json: post
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
    end

    def edit
        post = get_post_by_id(params[:id])
        post.update(post_params)
        render json: { message: "Updated successfully", post: get_post_by_id(params[:id]) }, status: :ok
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end

    def current_user
        # 最初にcurrent_userが呼び出されたとき、ユーザーのデータが@current_userに保存される。
        # 以降、保存された値が使用され、不要なデータベースへのクエリが省略される。
        # @current_user ||= ... は、@current_userが未定義またはnilの場合にのみ右側の式を評価する。
        # session[:user_id]が存在する場合に、User.findによってデータベースからユーザー情報を取得する。
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def get_post_by_id(id)
        Post.find(id)
    end
end
