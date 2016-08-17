class AddRedeemRequestToWalletTransactions < ActiveRecord::Migration
  def change
    add_reference :wallet_transactions, :redeem_request, index: true, foreign_key: true
  end
end
