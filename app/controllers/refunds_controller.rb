class RefundsController < ApplicationController
 
  def new
    @order = Order.find(params[:order])
    @order_detail = OrderDetail.find(params[:order_detail])

    @refundable_amount = @order_detail.amount
    @order_id = @order.id.to_i

    @refund = Refund.new
    @refund.user_id = current_user.id
    @refund.order_id = @order_id
    @refund.is_partial_refund = "true"
    @refund.amount_refunded = @refundable_amount

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
