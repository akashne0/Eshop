class Order < ApplicationRecord
    enum status: {ordered: 0, order_processing: 1, shipped: 2, out_for_delivery: 3, delivered: 4, return_in_process: 5, return_approved: 6, pickup_expected: 7, refunded: 8}

    has_one :coupon_used
    has_one :coupon, through: :coupon_used

    has_many :line_items, dependent: :destroy
    belongs_to :address
    
    belongs_to :user

    validates :address_id, presence: true
    validates :total, presence: true
    validates   :pay_type, presence: true

    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end

end
