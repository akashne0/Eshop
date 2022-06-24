class ContactAdminNotifierMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the contact object that contains the user's email address
  def admin_contact_notification(email, name, contact_no, message)
     @email = email
     @name = name
     @contact_no = contact_no
     @message = message
    mail( :to => 'admin@gmail.com',
    :subject => 'Thanks for choosing Eshop')
  end
end
