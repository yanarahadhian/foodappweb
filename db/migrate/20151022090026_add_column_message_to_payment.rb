class AddColumnMessageToPayment < ActiveRecord::Migration
  def change
  	add_column :payments, :message, :text
  end
end
