class ChangesDataTypeUsersAndItemsTable < ActiveRecord::Migration
  def change
  	change_column :users, :verified_fb, :text
  	change_column :users, :city, :string
  	change_column :items, :item_category_id, :integer, index: true, foreign_key: true
  	change_column :items, :user_id, :integer, index: true, foreign_key: true
  end
end
