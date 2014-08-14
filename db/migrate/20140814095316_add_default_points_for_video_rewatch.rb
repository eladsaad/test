class AddDefaultPointsForVideoRewatch < ActiveRecord::Migration
  def change
  	current_settings = AppSettings.player_score_update_points
    AppSettings.player_score_update_points = current_settings.merge({interactive_video_watch_again: 1000})
  end
end
