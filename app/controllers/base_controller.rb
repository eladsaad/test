class BaseController < ApplicationController
	before_filter :authenticate_player!
	before_filter :tos_accepted

	def tos_accepted
		unless current_player.tos_accepted
			store_location
			redirect_to edit_accept_tos_player_path
		end
	end

	def current_ability
		current_player.ability
	end

	def current_player_group
		# TODO: will need to change if a player is allowed more than one online program
		current_player.current_player_group
	end

	def current_online_program
		program = nil
		if (current_player)
			program ||= current_player.current_online_program
		else
			program ||= OnlineProgram.find_by_codename(OnlineProgram::DEFAULT_PROGRAM_CODE_NAME)
	      # TODO: change to fetch by subdomain
	  	end
	  	program
	end

end
