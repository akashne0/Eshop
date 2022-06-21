class NewsletterNotifierMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_subscribed_product_details(newsletter, products)
    @products = products
    @newsletter = newsletter
    mail( :to => @newsletter.email,
    :subject => 'Thanks for subscribing with our newsletter' )
  end
end
