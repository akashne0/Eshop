class AddStatusToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :status , :boolean
  end
end
