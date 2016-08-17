class ChangeDataTypeInOrders < ActiveRecord::Migration
  def change
  	change_column :orders, :order_date, :datetime
  end
end
