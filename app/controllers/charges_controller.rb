class ChargesController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  rescue_from Stripe::CardError, with: :catch_exception

  def new
    @total = params[:total]
    @pay_type = params[:pay_type]
    @address_id = params[:address_id]
    @coupon_id = params[:coupon_id]
  end

  def create

    @order = Order.new
    pay_type = params[:pay_type]
    address_id = params[:address_id].to_i
    @total = params[:total]
    coupon_id = params[:coupon_id]
    @amount = (@total*100).to_i

    # @order.pay_type = params
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :stripe_secret_key)

    # byebug
    payment_intent = Stripe::PaymentIntent.create(
      :customer => current_user.stripe_customer_id,
      :amount => @amount*100,
      :description => current_user.email ,
      :currency => 'inr',
      # :payment_method_options => { card: {request_three_d_secure: :null}},
      :payment_method_data => { type: 'card',
       card: {token: params[:stripeToken]},}
    )

    payment_confirm = Stripe::PaymentIntent.confirm(
      payment_intent.id,
      {payment_method: 'pm_card_visa'},
    )

    # byebug
    @order.pay_type = pay_type
    @order.coupon_id = coupon_id
    @order.address_id = address_id
    @order.total = params[:total].to_i
    @order.user_id = current_user.id
    @order.stripe_payment_id = payment_intent.id


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


# :payment_method_data => { type: 'card',
#   card: {token: params[:stripeToken]},

# payment_intent = Stripe::PaymentIntent.create(:customer => current_user.stripe_customer_id,:amount => @amount*100,:description => current_user.email,:currency => 'inr',:payment_method_data => { type: 'card', card: {token: params[:stripeToken]}},)
  # confirmation_method: 'manual',
  # :confirm => true,

# payment_confirm = Stripe::PaymentIntent.confirm(payment_intent.id,{payment_method: 'pm_card_threeDSecureOptional'},)
