class AddNotesToInvitaions < ActiveRecord::Migration
  def change
    add_column :invitations, :notes, :text
  end
end
