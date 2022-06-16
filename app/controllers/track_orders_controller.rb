class TrackOrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create, :show]

  def new
  end

  def show

  end

  def create
    if params[:anything][:email].empty?
      redirect_to new_track_order_path, notice: "Your Email Is Missing!"

    elsif params[:anything][:order_id].empty?
      redirect_to new_track_order_path, notice: "Your Order Id Is Missing!"

    else
      @email = params[:anything][:email]
      @order_id = params[:anything][:order_id].to_i
  
      @order = current_user.orders.find(@order_id)
      @status = @order.status
  
      respond_to do |format|
          format.js {}
      end
    end
   
  end
end
