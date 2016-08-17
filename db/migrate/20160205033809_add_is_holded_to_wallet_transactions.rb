class AddIsHoldedToWalletTransactions < ActiveRecord::Migration
  def change
    add_column :wallet_transactions, :is_holded, :boolean
  end
end
