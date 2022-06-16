class Product < ApplicationRecord
    has_many :product_images
    has_many :product_categories, dependent: :destroy
    has_many :categories,  through: :product_categories
    has_many :line_items
    has_many :orders, through: :line_items
    has_one :wishlist
    before_destroy :ensure_not_referenced_by_any_line_item


    private

    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'Line Items present')
            return false
        end
    end

end
