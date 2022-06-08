Rails.application.routes.draw do

  resources :orders
  resources :line_items
  resources :carts 
  resources :coupons 
  resources :addresses

  post 'check_coupon_code', to: 'coupons#check_coupon_code'
  
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}
    
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products, only: [:index, :show] 
  
  resources :categories, only: [:show]
  resources :webhooks, only: [:create]
  
  resources :charges, only: [:new, :create]
  resources :paypals, only: [:new, :create]
  # get 'products/cart', to: 'products#cart' , as: "products_cart"

end
 