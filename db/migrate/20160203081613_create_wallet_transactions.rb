class CreateWalletTransactions < ActiveRecord::Migration
  def change
    create_table :wallet_transactions do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :amount
      t.string :description

      t.timestamps null: false
    end
  end
end
