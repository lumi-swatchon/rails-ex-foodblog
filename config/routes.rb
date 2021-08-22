Rails.application.routes.draw do
  resources :stores
  resources :menus
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "welcome#index"
end
