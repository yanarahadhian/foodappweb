class AddColumnToInvitations < ActiveRecord::Migration
  def change
  	add_column :invitations, :ref_id, :text
  	add_column :invitations, :username, :string
  	add_column :invitations, :invitation_id, :integer
  	add_index :invitations, :username, :unique => true
  end
end
