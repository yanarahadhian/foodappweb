class AddRedeemTokenAndRedeemTokenExpireAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :redeem_token, :string
    add_column :users, :redeem_token_expire, :datetime
  end
end
