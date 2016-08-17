class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.integer :user_id
    	t.integer	:store_id
    	t.integer	:custom_address_id
    	t.integer :quantity
    	t.string	:description
    	t.string	:status
    	t.boolean	:is_deleted_seller
    	t.string	:verification_code
    	t.integer	:rating

      t.timestamps null: false
    end
  end
end
