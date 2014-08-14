class RemovePlayerGroupIdFromScore < ActiveRecord::Migration
  def change
  	remove_column :scores, :player_group_id, :integer
  end
end
