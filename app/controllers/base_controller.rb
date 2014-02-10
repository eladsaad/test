class BaseController < ApplicationController
	before_filter :authenticate_player!

	def current_ability
		current_player.ability
	end

	def current_player_group
		# TODO: will need to change if a player is allowed more than one online program
		current_player.current_player_group
	end

end
