class UserNotifierMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the user object that contains the user's email address
  def user_creation_notification(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for choosing Eshop')
  end
end
