class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all 
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Your Cart Is Empty"
      return
    end
    @order = Order.new
    @total = params[:total]
    @address_id = params[:address_id]
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
      redirect_to new_charge_path(:total => total) 
    elsif params[:commit] == 'Paypal'
      redirect_to new_paypal_path
    else params[:commit] == 'Cash On Delivery'
      #to add paytype to order
      @order.pay_type = params[:commit]

      respond_to do |format|

        if @order.save
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil

          format.html { redirect_to root_url, notice: "Thankyou for your order" }
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
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
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
