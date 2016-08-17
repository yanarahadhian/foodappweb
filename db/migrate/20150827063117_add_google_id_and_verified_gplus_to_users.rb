class AddGoogleIdAndVerifiedGplusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_id, :string
    add_column :users, :verified_gplus, :text
  end
end
