class CreateProductImages < ActiveRecord::Migration[6.1]
  def change
    create_table :product_images do |t|
      t.references :product, null: false, foreign_key: true
      t.string      :image_name
      t.boolean     :status
      t.integer     :created_by
      t.date        :created_date
      t.integer     :modify_by
      t.date        :modify_date

      t.timestamps
    end
  end
end
