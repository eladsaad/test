class AddIndexToScores < ActiveRecord::Migration
  def change
      add_index :scores, :player_group_id
      add_index :scores, :player_id
  end
end