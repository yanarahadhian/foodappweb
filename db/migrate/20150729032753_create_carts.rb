class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
    	t.integer :user_id
    	t.string :is_paid
    	
    	t.timestamps
    end
  end
end
