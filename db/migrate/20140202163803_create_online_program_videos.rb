class CreateOnlineProgramVideos < ActiveRecord::Migration
  def change
    create_table :online_program_videos do |t|
      t.integer :online_program_id
      t.integer :video_id
      t.datetime :relative_time_sec
      t.integer :pre_survey_id
      t.integer :post_survey_id

      t.timestamps
    end

    add_index :online_program_videos, :online_program_id
    add_index :online_program_videos, :video_id
  end
end
