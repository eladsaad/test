class RenameGroupProgramStartDate < ActiveRecord::Migration
  def change
  	rename_column :player_groups, :program_start_date, :screening_date
  end
end
