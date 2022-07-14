class ChargesController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  rescue_from Stripe::CardError, with: :catch_exception

  def new
    @total = params[:total]
    @pay_type = params[:pay_type]
    @address_id = params[:address_id]
  end

  def create
    @order = Order.new
    @pay_type = params[:pay_type]
    @address_id = params[:address_id]
    @total = params[:total]
    @amount = (@total*100).to_i

    # @order.pay_type = params
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :stripe_secret_key)

    # byebug

    payment_intent = Stripe::PaymentIntent.create(
      :customer => current_user.stripe_customer_id,
      :amount => @amount*100,
      :description => current_user.email ,
      :currency => 'usd',
      :payment_method_data => { type: 'card',
        card: {
            token: params[:stripeToken]
        },
    })

    byebug
    
    @order.pay_type = params[:pay_type]
    @order.address_id = params[:address_id].to_i
    @order.total = params[:total].to_i
    @order.user_id = current_user.id


    puts @order.inspect

    respond_to do |format|
      if @order.save
        add_from_cart_to_order_details(@cart, @order)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to root_url, notice: "Your Order Has Been Placed.Thank you For Shopping With Us !!" }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def catch_exception(exception)
    flash[:error] = exception.message
  end


end

# different method for stripe
# def create
#   @order = Order.new
#   @order.add_line_items_from_cart(@cart)
#   @total = params[:total]
#   @amount = (@total*100).to_i

#   Stripe.api_key = Rails.application.credentials.dig(:stripe, :stripe_secret_key)
#   customer = Stripe::Customer.create(
#     email: params[:stripeEmail],
#     source: params[:stripeToken]
#   )

#   @session = Stripe::Checkout::Session.create({
#     payment_method_types: [:card],
#     line_items: [{
#       customer: customer.id,
#       amount: @amount,
#       description: 'Rails Stripe transaction',
#       currency: "usd"
#     }],
#     mode: 'payment',
#     success_url: root_url,
#     cancel_url: root_url,
#   })

#   respond_to do |format|
#      @order.save
#       Cart.destroy(session[:cart_id])
#       session[:cart_id] = nil

#       format.js {}
#   end
# end
