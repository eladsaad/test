class AddInvitedPlayerIdToPlayerInvite < ActiveRecord::Migration
  def change
    add_column :player_invites, :invited_player_id, :integer
  end
end
