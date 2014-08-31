class ModifyScoreUpdatePoints < ActiveRecord::Migration
  def change
  	current_settings = AppSettings.player_score_update_points
    AppSettings.player_score_update_points = current_settings.merge({
    	interactive_video_watch_again: 1000,
    	first_login: 500,
      	invited_player_registered: 1000,
      	survey_answer: 10000,
      	interactive_video_watch: 2000,
      	interactive_video_watch_early: 3000,
	})
  end
end
