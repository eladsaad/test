class BaseController < ApplicationController
	before_filter :authenticate_player!

	def current_ability
		current_player.ability
	end
end
