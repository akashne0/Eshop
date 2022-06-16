class CreateCouponUseds < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_useds do |t|
      t.integer :user_id
      t.integer :coupon_id
      t.integer :order_id
      
      t.timestamps
    end
  end
end
