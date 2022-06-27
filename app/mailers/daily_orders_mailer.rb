class DailyOrdersMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the user object that contains the user's email address
  def send_consolidated_order(orders_created)
   @orders_created = orders_created 
    mail( :to => "admin@gmail.com",
      :subject => 'All order details')
  end
end
