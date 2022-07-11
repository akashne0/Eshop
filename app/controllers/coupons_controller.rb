class CouponsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

    def index
      @coupons = Coupon.all
    end

    def show
    end

    def new
      @coupon = Coupon.new
    end
r1e
    def check_coupon_code
      code = params[:coupon][:code]
      total = params[:coupon][:total]
      @shipping_cost = params[:coupon][:shipping_cost].to_f

      if code.present? and total.present?
        @coupon = Coupon.where(code: code).first
        @coupon_price = total.to_f * (@coupon.percent_off/100)

        if @shipping_cost.present?
          @total = ((total.to_f)-(@coupon_price)) + @shipping_cost
        else
          @total = ((total.to_f)-(@coupon_price))
        end
        respond_to do |format|
          format.js {}
        end
      else
        respond_to do |format|
          format.html { redirect_to cart_url(@cart), notice: "Invalid Coupon Code."}
        end
      end
    end

    def remove_coupon
      byebug
      @cart_total = @cart.total.to_f
      @shipping_cost = params[:shipping_cost].to_f

      @total = @cart_total + @shipping_cost
      respond_to do |format|
        format.js {}
      end

    end


end
