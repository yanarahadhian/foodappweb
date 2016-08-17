class ChangeRatingInOrders < ActiveRecord::Migration
 def up
   change_column :orders, :rating, :float
 end

 def down
   change_column :orders, :rating, :integer
 end
end