class CreateNewsletters < ActiveRecord::Migration[6.1]
  def change
    create_table :newsletters do |t|
      t.string :email
      t.string :categories
      t.timestamps
    end
  end
end
