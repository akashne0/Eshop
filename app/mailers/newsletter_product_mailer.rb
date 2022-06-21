class NewsletterProductMailer < ApplicationMailer

    default :from => 'rahuls3096@gmail.com'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_subscribed_product_details(newsletter)
    @newsletter = newsletter
    @products = []
    category_ids = @newsletter.categories
    product_categories = ProductCategory.where(category_id: category_ids)

    product_categories.each do |product_category|
      if Date.today.day - product_category.product.created_at.day == 1
        @products << product_category.product
      end
    end
    

    mail( :to => @newsletter.email,
    :subject => 'Thanks for subscribing with our newsletter' )
  end
end
