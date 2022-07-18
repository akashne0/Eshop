class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create, :index, :show, :get_deleted_products]
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1 or /orders/1.json
  def show
    @address = Address.find(@order.address_id)
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Your Cart Is Empty"
      return
    elsif params[:address_id].to_i == 0
      redirect_to cart_path(@cart), notice: "Please Add Address To Continue"
      return
    else
      @order = Order.new
      @total = params[:total]
      @address_id = params[:address_id]
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    total = params["order"][:total]
    address_id = params["order"][:address_id]
    # params["order"].delete(:total)

    @order = Order.new(order_params)
    # @order.add_line_items_from_cart(@cart)

    if params[:commit] == 'Stripe'
      redirect_to new_charge_path(:total => total, :pay_type => 'Stripe', :address_id => address_id)
    elsif params[:commit] == 'Paypal'
      redirect_to new_paypal_path
    else params[:commit] == 'Cash On Delivery'
      #to add paytype to order
      @order.pay_type = params[:commit]
      @order.user_id = current_user.id

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
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    # @refund  = Refund.find_by(order_id: @order.id)
    #stripe refund gateway
    # byebug
    @order =Order.find(params[:id])
    @amount = @order.order_details.pluck(:amount).inject(:+).to_i

    Stripe.api_key = Rails.application.credentials.dig(:stripe, :stripe_secret_key)
    stripe_refund =  Stripe::Refund.create(payment_intent: @order.stripe_payment_id)

    #refund model
    @refund = Refund.new
    @refund.user_id = current_user.id
    @refund.order_id = @order.id.to_i
    @refund.is_partial_refund = "false"
    @refund.amount_refunded = stripe_refund.amount
    @refund.stripe_refund_id = stripe_refund.id
    @refund.save

    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: " Entire Order Was Cancelled Successfully. Refund Initiated Will Be Visible in 3-5 Working Day" }
      format.json { head :no_content }
    end
  end

  def remove_product_from_order
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order

    redirect_to new_refund_path(order_detail: @order_detail, order: @order)
  end

  def get_deleted_products
    products = current_user.orders.with_deleted.order(deleted_at: :desc)
    @products = products.first(3)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:address_id, :total, :pay_type)
    end
end

# stripe_refund =  Stripe::Refund.create(payment_intent: @order.stripe_payment_id ,amount: @amount)
