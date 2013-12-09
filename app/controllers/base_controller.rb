class BaseController < ApplicationController
	before_filter :authenticate_player!
end
