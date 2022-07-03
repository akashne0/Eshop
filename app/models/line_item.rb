class LineItem < ApplicationRecord
  before_save :set_total
  before_save :set_unit_price
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart, optional: true

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total
    product.price * quantity
  end
   
  def subtotal
    line_items.collect{|line_item| line_item.valid? ? line_item.unit_price*line_item.quantity : 0}.sum
  end
  

  private
    def set_unit_price
      self[:unit_price] = unit_price      
    end

    def set_total
      self[:total] = total * quantity      
    end

    def set_subtotal
      self[:subtotal] = subtotal
  end
end
