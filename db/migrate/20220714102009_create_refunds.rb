class CreateRefunds < ActiveRecord::Migration[6.1]
  def change
    create_table :refunds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :state
      t.string :stripe_refund_id
      t.boolean :is_partial_refund
      t.float :amount_refunded

      t.timestamps
    end
  end
end
