Rails.application.routes.draw do
  resources :users
  resource  :sessions,  only: [:create, :destroy]
end
