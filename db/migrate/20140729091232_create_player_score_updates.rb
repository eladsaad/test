class CreatePlayerScoreUpdates < ActiveRecord::Migration
  def change
    create_table :player_score_updates do |t|
      t.integer :player_id
      t.string :event
      t.integer :points
      t.boolean :reported, default: false
      t.text :data

      t.timestamps
    end

    add_index :player_score_updates, :player_id

    # Default points

    AppSettings.player_score_update_points = {
      first_login: 1000,
      invited_player_registered: 2500,
      survey_answer: 1000,
      interactive_video_watch: 1000,
      interactive_video_watch_early: 3000,
    }
  end
end
