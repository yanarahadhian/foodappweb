class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
    	t.integer :cart_id
    	t.integer :item_id
    	t.string	:amount
    	t.decimal	:item_price
    	t.decimal	:sub_total
    	t.decimal	:vat_total
    	t.decimal	:total

    	t.timestamps
    end
  end
end
