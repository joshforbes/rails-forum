Rails.application.routes.draw do
  resources :posts
  resources :users
  resource  :sessions,  only: [:create, :destroy]
end
