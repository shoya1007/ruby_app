Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/users', to: 'user#create'
  post '/users/login', to: 'user#login'
  get '/users/me', to: 'user#show'
  put '/users/me', to: 'user#edit'
  get '/healthz', to: 'health_check#show'
  post '/posts', to: 'post#create'
  get '/posts', to: 'post#index'
  get '/posts/:id', to: 'post#show'
  put '/posts/:id', to: 'post#edit'
  delete '/posts/:id', to: 'post#delete'
  # 本当はresourcesを使った書き方の方がいいらしいが、今回の実装ではcontroller名がpostなのでエンドポイント名も/postになってしまうのでコメントアウト。
  # resources :post, only: [:index]
end
