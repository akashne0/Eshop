class RemovePaytypeFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :paytype , :string
    remove_column :orders, :email , :string
    remove_column :orders, :name , :string
    
  end
end
