class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    

    def add_product(product_id)
        current_item = line_items.find_by(product_id: product_id)
        if current_item
            current_item.quantity += 1
        else
            current_item = line_items.build(product_id: product_id)
        end
        current_item
    end

    def total
        line_items.to_a.sum {|item| item.total}
    end


    def subtotal
        line_items.collect{|line_item| line_item.valid? ? line_item.unit_price*line_item.quantity : 0}.sum
    end

    private

    def set_subtotal
        self[:subtotal] = subtotal
    end
end

