class CouponsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :remove_coupon, :check_coupon_code]

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
      @cart_total = params[:coupon][:total]
      @shipping_cost = params[:coupon][:shipping_cost].to_f
        @coupon = Coupon.where(code: code).first
        if @coupon.present?
          @coupon_price = @cart_total.to_f * (@coupon.percent_off/100)

          if @shipping_cost.present?
            @total = ((@cart_total.to_f)-(@coupon_price)) + @shipping_cost
          else
            @total = ((@cart_total.to_f)-(@coupon_price))
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
      @cart = params[:total].to_f
      @shipping_cost = params[:shipping_cost].to_f
      @coupon = Coupon.new

      @total = @cart + @shipping_cost

      @message = "You Have Removed The Coupon.!!"
      respond_to do |format|
        format.js {}
      end

    end


end
