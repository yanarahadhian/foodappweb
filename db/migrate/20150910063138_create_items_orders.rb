class CreateItemsOrders < ActiveRecord::Migration
  def change
    create_table :items_orders, id: false do |t|
    	t.belongs_to	:item, index: true
    	t.belongs_to :order, index: true
    end
  end
end
