class PrepareToRemovePlayerGroupAssociationTable < ActiveRecord::Migration
  def change
  	add_column :players, :player_group_id, :integer
  	remove_column :player_progresses, :player_group_id, :integer
  end
end
