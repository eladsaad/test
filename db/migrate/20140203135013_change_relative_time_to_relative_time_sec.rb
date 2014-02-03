class ChangeRelativeTimeToRelativeTimeSec < ActiveRecord::Migration
  def change
  	remove_column :online_program_videos, :relative_time
  	add_column :online_program_videos, :relative_time_sec, :integer

  	remove_column :online_program_notifications, :relative_time
  	add_column :online_program_notifications, :relative_time_sec, :integer
  end
end
