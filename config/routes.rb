Rails.application.routes.draw do
  resources :conversations
  resources :messages
  resources :products
  get 'users/:id/products', to: 'users#user_products'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
