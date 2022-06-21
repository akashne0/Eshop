class AddConfirmedAtToNewsletter < ActiveRecord::Migration[6.1]
  def change
    add_column :newsletters, :confirmed_at, :datetime
  end
end
