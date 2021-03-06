class BaseController < ApplicationController

	before_filter :authenticate_player!
	before_filter :verify_complete_player_registration

	def verify_complete_player_registration
		unless current_player.registration_complete?
			store_location
			redirect_to edit_player_registration_path
		end
	end

	def current_ability
		current_player.ability
	end

	def current_player_group
		current_player.player_group
	end

end
