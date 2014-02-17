class RenameOnlineProgramVideoToOnlineProgramInteractiveVideo < ActiveRecord::Migration
  def change
  	rename_table :online_program_videos, :online_program_interactive_videos
  end
end
