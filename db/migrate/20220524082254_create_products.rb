class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string          :name
      t.string          :sku
      t.string          :short_description 
      t.text            :long_description
      t.float           :price
      t.float           :special_price
      t.date            :special_price_from
      t.date            :special_price_to
      t.boolean         :status
      t.integer         :quantity
      t.string          :meta_title
      t.text            :meta_description
      t.text            :meta_keywords
      t.integer         :created_by 
      t.date            :created_date
      t.integer         :modify_by
      t.date            :modify_date
      
      t.timestamps
    end
  end
end
