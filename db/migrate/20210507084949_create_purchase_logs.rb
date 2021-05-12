class CreatePurchaseLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end
