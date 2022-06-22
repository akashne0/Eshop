class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentCart
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart
  before_action :set_wishlist

  def add_from_cart_to_order_details(cart, order)
    cart.line_items.each do |line_item|
      order_detail = OrderDetail.create(order_id: order.id, product_id: line_item.product.id, quantity: line_item.quantity, amount: line_item.total) 
    end
  end
    
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
  end
 
end


