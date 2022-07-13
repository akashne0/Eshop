class OrderDetail < ApplicationRecord
    acts_as_paranoid

    enum status: {ordered: 0, order_processing: 1, shipped: 2, out_for_delivery: 3, cancelled: 4, delivered: 5, return_in_process: 6, return_approved: 7, pickup_expected: 8, refunded: 9}

    belongs_to :order, -> {with_deleted}

    after_create :send_user_order_details
        
    def send_user_order_details
        UserOrderDetailsMailer.user_order_details_notification(order_id,product_id).deliver
    end
end
