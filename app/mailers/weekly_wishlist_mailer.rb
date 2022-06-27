class WeeklyWishlistMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the user object that contains the user's email address
  def send_users_wishlist(users_wishlist)
   @users_wishlist = users_wishlist 
    mail( :to => "admin@gmail.com",
      :subject => 'All order details')
  end
end
