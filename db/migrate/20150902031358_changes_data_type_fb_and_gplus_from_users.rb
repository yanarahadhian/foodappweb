class ChangesDataTypeFbAndGplusFromUsers < ActiveRecord::Migration
  def change
  	change_column :users, :verified_fb, :boolean
  	change_column :users, :verified_gplus, :boolean
  end
end
