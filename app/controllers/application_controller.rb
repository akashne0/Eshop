class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentCart
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart
  before_action :set_wishlist

  def add_from_cart_to_order_details(cart, order)
    # byebug
    coupon = Coupon.find(order.coupon_id).percent_off
    coupon_off = coupon/100
    cart.line_items.each do |line_item|
      total = line_item.total - (line_item.total * coupon_off)
      order_detail = OrderDetail.create(order_id: order.id, product_id: line_item.product.id, quantity: line_item.quantity, amount: total)
    end
    # byebug
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
  end

end
