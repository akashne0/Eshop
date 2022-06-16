Rails.application.routes.draw do
  
  root 'products#index'
  get 'home/index', to: 'home#index' 
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'} 
  resources :orders
  resources :line_items
  resources :carts 
  resources :coupons 
  post 'check_coupon_code', to: 'coupons#check_coupon_code'
  resources :addresses
  resources :wishlists
  delete 'remove_from_wishlist', to: 'wishlists#remove_from_wishlist' 
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :products, only: [:index, :show] 
  resources :categories, only: [:show]
  resources :webhooks, only: [:create]
  resources :charges, only: [:new, :create]
  resources :paypals, only: [:new, :create]  
  resources :track_orders,only: [:new, :create, :show]  

end
 