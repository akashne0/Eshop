class UserOrderDetailsMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the user object that contains the user's email address
  def user_order_details_notification(order_id, product_id)
    @order = Order.find(order_id)
    @orders = @order.order_details
    @email = @order.user.email
    @address = @order.address
    mail( :to => @email,
    :subject => 'Your Order details')
  end
end
