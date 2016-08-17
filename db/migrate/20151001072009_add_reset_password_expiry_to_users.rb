class AddResetPasswordExpiryToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :reset_password_expiry, :datetime
  end
end
