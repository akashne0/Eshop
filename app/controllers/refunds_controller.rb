class RefundsController < ApplicationController
 
  def new
    @order = Order.find(params[:order])
    @order_detail = OrderDetail.find(params[:order_detail])

    #stripe refund gateway
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :stripe_secret_key)
    stripe_refund =  Stripe::Refund.create(
      payment_intent: @order.stripe_payment_id ,
      amount: @order_detail.amount )

    #refund model
    @refund = Refund.new
    @refund.user_id = current_user.id
    @refund.order_id = @order.id.to_i
    @refund.is_partial_refund = "true"
    @refund.amount_refunded = @order_detail.amount

    byebug
    @refund.save
    @order_detail.destroy

    @order.order_details.with_deleted.each do |order_detail|
      order_detail.status = "cancelled"
      order_detail.save
    end

    respond_to do |format|
      format.html { redirect_to @order, notice: "Your Product Is cancelled And Refund Initiated!!." }
      format.json { head :no_content }
    end


  end

  def destroy
  end
end
