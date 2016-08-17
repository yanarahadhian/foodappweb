class AddNewColumnToOrders < ActiveRecord::Migration
  def change
  	add_reference :orders, :item, index: true
  	change_column	:orders, :status, :integer
  	change_column :orders, :description, :text
  	add_column :orders, :order_date, :date
  	add_column :orders, :order_id, :string
  	add_column :orders, :rating_string, :text
  end
end
