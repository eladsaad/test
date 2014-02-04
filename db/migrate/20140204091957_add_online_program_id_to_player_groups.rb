class AddOnlineProgramIdToPlayerGroups < ActiveRecord::Migration
  def change
    add_column :player_groups, :online_program_id, :integer
  end
end
