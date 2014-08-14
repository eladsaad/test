class RemoveGroupIdFromPlayerAnswer < ActiveRecord::Migration
  def change
  	remove_column :player_answers, :player_group_id, :integer
  end
end
