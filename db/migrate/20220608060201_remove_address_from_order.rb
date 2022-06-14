class RemoveAddressFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :address , :text
  end
end
