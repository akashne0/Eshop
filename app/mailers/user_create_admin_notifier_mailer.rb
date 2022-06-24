class UserCreateAdminNotifierMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the user object that contains the user's email address
  def user_creation_admin_notification(email)
     @email = email
    mail( :to => "admin@gmail.com",
    :subject => 'Thanks for choosing Eshop')
  end
end
