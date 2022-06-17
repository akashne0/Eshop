class CreateContactUs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_us do |t|
      t.string  :name 
      t.string  :email
      t.string  :contact_no
      t.text    :message
      t.text    :admin_note
      t.integer :created_by
      t.date    :created_date
      t.integer :modify_by
      t.date    :modify_dat e

      t.timestamps
    end
  end
end
