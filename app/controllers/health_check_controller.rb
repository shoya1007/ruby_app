class HealthCheckController < ApplicationController

    def show
        render json: {message: "OK"}, status: :ok
    end
end
