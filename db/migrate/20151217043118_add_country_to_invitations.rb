class AddCountryToInvitations < ActiveRecord::Migration
  def change
  	add_column :invitations, :country, :string
  	remove_column :invitations, :last_name
  end
end
