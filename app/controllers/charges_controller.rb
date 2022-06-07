class ChargesController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def new
    @total = params[:total]
  end

  def create
    @order = Order.new
    @order.add_line_items_from_cart(@cart)
    @total = params[:total]
    @amount = (@total*100).to_i
   
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    Stripe::PaymentIntent.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Rails Stripe transaction',
      :currency => 'usd'
    )
  
    respond_to do |format|
       @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to root_url, notice: "Thankyou for your order.You paid #{@total}" }
        format.json { render :show, status: :created, location: @order }
    end
  end
  
end
