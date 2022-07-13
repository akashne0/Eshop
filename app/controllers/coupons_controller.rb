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

    def check_coupon_code
      @message = ""
      code = params[:coupon][:code]
      total = params[:coupon][:total]
      @shipping_cost = params[:coupon][:shipping_cost].to_f
        @coupon = Coupon.where(code: code).first
        if @coupon.present?
          @coupon_price = total.to_f * (@coupon.percent_off/100)

          if @shipping_cost.present?
            @total = ((total.to_f)-(@coupon_price)) + @shipping_cost
          else
            @total = ((total.to_f)-(@coupon_price))
          end
          @message = "Coupon Is Applied And Discount of #{@coupon.percent_off.to_i}%  Is Added!!"
        else
          @message = "You Have Applied An Invalid Coupon !!"
        end
        respond_to do |format|
          format.js {}
        end
    end

    def remove_coupon
      # byebug
      @cart_total = @cart.total.to_f
      @shipping_cost = params[:shipping_cost].to_f

      @total = @cart_total + @shipping_cost
      respond_to do |format|
        format.js {}
      end

    end


end
