class CreateProductAttributesAssocs < ActiveRecord::Migration[6.1]
  def change
    create_table :product_attributes_assocs do |t|
      # t.references :product, null: false, foreign_key: true
      # t.references :product_attribute, null: false, foreign_key: true
      # t.references :product_attribute_value, null: false, foreign_key: true 

      # t.timestamps
    end
  end
end
