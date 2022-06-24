class OrderDetail < ApplicationRecord
    belongs_to :order

    after_create :send_user_order_details
        
    def send_user_order_details
        UserOrderDetailsMailer.user_order_details_notification(order_id,product_id).deliver
    end
end
