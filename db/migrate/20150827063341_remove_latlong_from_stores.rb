class RemoveLatlongFromStores < ActiveRecord::Migration
  def change
  	remove_column :stores, :latlong, :string
  end
end
