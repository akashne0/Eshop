class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer  :user_id
      t.string   :address_1
      t.string   :address_2
      t.string   :city
      t.string   :state
      t.string   :country
      t.string   :zipcode
  
      t.timestamps
    end
  end
end
