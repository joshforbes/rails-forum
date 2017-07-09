Rails.application.routes.draw do
  resources :users
  resource  :sessions,  only: [:create, :destroy]
  resources :posts do
    resources :comments, shallow: true
  end
end
