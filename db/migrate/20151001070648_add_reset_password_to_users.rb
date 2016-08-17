class AddResetPasswordToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :reset_password_digest, :text
  end
end
