class OrderNotifierMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the user object that contains the user's email address
  def order_update_notification(id)
    @order = Order.find(id)
    @email = @order.user.email
    @address = @order.address
    @status = @order.status
    mail( :to => @email,
      :subject => 'Thanks for choosing Eshop')
  end
end
