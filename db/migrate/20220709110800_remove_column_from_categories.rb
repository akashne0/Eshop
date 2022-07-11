class RemoveColumnFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :created_date, :date
    remove_column :categories, :modify_date, :date
    remove_column :cms, :created_date, :date
    remove_column :cms, :modify_date, :date
    remove_column :configurations, :created_date, :date
    remove_column :configurations, :modify_date, :date
    remove_column :contact_us, :created_date, :date
    remove_column :contact_us, :modify_date, :date
    remove_column :contacts, :created_date, :date
    remove_column :contacts, :modify_date, :date
    remove_column :product_images, :created_date, :date
    remove_column :product_images, :modify_date, :date
    remove_column :products, :created_date, :date
    remove_column :products, :modify_date, :date
  end
end
