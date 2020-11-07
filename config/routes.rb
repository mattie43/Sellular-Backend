Rails.application.routes.draw do
  resources :conversations
  resources :messages
  resources :products
  get 'users/:id/products', to: 'users#user_products'
  get 'users/:id/convos', to: 'users#convos'
  post 'users/signup', to: 'users#signup'
  post 'users/login', to: 'users#login'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
