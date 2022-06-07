class CreateConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :configurations do |t|
      t.string :conf_key
      t.string :conf_value
      t.integer :created_by
      t.date    :created_date
      t.integer :modify_by
      t.date    :modify_date
      t.boolean :status

      t.timestamps
    end
  end
end
