class Order < ApplicationRecord
    acts_as_paranoid

    enum status: {ordered: 0, order_processing: 1, shipped: 2, out_for_delivery: 3, cancelled: 4, delivered: 5, return_in_process: 6, return_approved: 7, pickup_expected: 8, refunded: 9}

    has_one :coupon_used
    has_one :coupon, through: :coupon_used

    # has_many :line_items, dependent: :destroy
    # has_many :products, through: :line_items
    has_many :order_details, dependent: :destroy

    belongs_to :address, optional: true
    belongs_to :user, optional: true

    validates :address_id, presence: true
    validates :total, presence: true
    validates :pay_type, presence: true

    # after_update :send_order_notification

    def send_order_notification
        OrderNotifierMailer.order_update_notification(id).deliver
    end

    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end

end
