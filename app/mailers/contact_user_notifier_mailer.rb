class ContactUserNotifierMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # pass in the contact object that contains the user's email address
  def user_contact_notification(email, name, contact_no, message, admin_note)
     @email = email
     @name = name
     @contact_no = contact_no
     @message = message
     @admin_note = admin_note
    mail( :to => email,
    :subject => 'Thanks for choosing Eshop')
  end
end
