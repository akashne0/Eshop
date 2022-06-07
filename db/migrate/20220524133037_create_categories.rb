class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string   :name
      t.integer  :parent_id
      t.integer  :created_by
      t.date     :created_date
      t.integer  :modify_by
      t.date     :modify_date
      t.boolean  :status
      
      t.timestamps
    end
  end
end
