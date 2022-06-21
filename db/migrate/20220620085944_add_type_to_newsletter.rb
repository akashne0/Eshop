class AddTypeToNewsletter < ActiveRecord::Migration[6.1]
  def change
    add_column :newsletters, :subscription_type, :string
  end
end
