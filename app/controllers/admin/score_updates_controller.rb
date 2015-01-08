class  Admin::ScoreUpdatesController < Admin::AdminController

	def edit
		authorize! :edit, :score_updates
	    @score_updates = current_settings
	end

	def update
		authorize! :update, :score_updates
		# merge with current settings
		parameters_hash = admin_score_updates_params.to_h.symbolize_keys!
    	AppSettings.player_score_update_points = current_settings.merge(parameters_hash)
		redirect_to edit_admin_score_updates_path
	end

	private

		def current_settings
			AppSettings.player_score_update_points
		end

		def admin_score_updates_params
	      params.require(:score_updates).permit(
	      	:interactive_video_watch_again,
	      	:first_login,
	      	:invited_player_registered,
	      	:survey_answer,
	      	:interactive_video_watch,
	      	:interactive_video_watch_early,
          :extra_for_first_movie,
          :extra_for_second_movie,
          :extra_for_third_movie,
          :extra_for_fourth_movie,
          :extra_for_fifth_movie,
          :extra_for_sixth_movie
	      )
	    end

end