module ApplicationHelper

  def get_image_by_product_id(order_detail)
    product = Product.find(order_detail.product_id)
    product.product_images.first
  end

  def get_name_by_product_id(order_detail)
    product = Product.find(order_detail.product_id)
    product.name.capitalize 
  end

  def get_description_by_product_id(order_detail)
    product = Product.find(order_detail.product_id)
    product.short_description.capitalize
  end

end
