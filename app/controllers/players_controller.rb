class PlayersController < BaseController

	skip_before_filter :tos_accepted, only: [:edit_accept_tos, :update_accept_tos]

	def edit_accept_tos
		@player = current_player
		authorize! :accept_tos, @player
		redirect_back_or interactive_videos_path if @player.tos_accepted
	end

	def update_accept_tos
		@player = current_player
		authorize! :accept_tos, @player
		@player.tos_accepted = params.require(:player).permit(:tos_accepted)[:tos_accepted]
		if @player.save
			redirect_back_or interactive_videos_path
		else
			render action: 'edit_accept_tos'
		end
	end

end
