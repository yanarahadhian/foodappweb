class ChangeNameColumnInvitationId < ActiveRecord::Migration
  def change
  	rename_column :invitations, :invitation_id, :inviter_id
  end
end
