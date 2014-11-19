class ReModifyScoreUpdatePoints < ActiveRecord::Migration
  def change
  	current_settings = AppSettings.player_score_update_points
    AppSettings.player_score_update_points = current_settings.merge({
    	interactive_video_watch_again: 20,
    	first_login: -1,
      	invited_player_registered: -1,
      	survey_answer: 80,
      	interactive_video_watch: 30,
      	interactive_video_watch_early: 50,
	})
  end
end
