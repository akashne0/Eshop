class RemoveColumnFromCm < ActiveRecord::Migration[6.1]
  def change
    remove_column :cms, :content, :text
  end
end
