class ChangeProgramVideoToInteractiveVideo < ActiveRecord::Migration
  def change
  	rename_column :online_program_videos, :video_id, :interactive_video_id
  end
end
