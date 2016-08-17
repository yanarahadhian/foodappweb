class AddUserIdToPayment < ActiveRecord::Migration
  def change
  	add_column :payments, :stripe, :text
  end
end
