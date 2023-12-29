Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/users', to: 'user#create'
  post '/users/login', to: 'user#login'
  get '/users/me', to: 'user#show'
  put '/users/me', to: 'user#edit'
  get '/healthz', to: 'health_check#show'
end
