class Api::BaseApiController < ApplicationController

  layout 'layouts/base_api'

  protect_from_forgery with: :null_session

  before_filter :authenticate_player_by_api_key!
  before_filter :verify_complete_player_registration

  respond_to :json

  def current_ability
  	current_player.ability
  end

  # rescue_from CanCan::AccessDenied, :with => { render :json => 'Access Denied', :status => 403 }
  rescue_from CanCan::AccessDenied do |exception|
  	Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
  	render_error(:access_denied)
  end

	
  protected 

  	# == Api Key Authentication ==

  	def authenticate_player_by_api_key!
		authenticate_by_token || render_unauthorized
	end

	def authenticate_by_token
		authenticate_with_http_token do |token, options|
			player_api_key = PlayerApiKey.where(access_token: token).first
			if player_api_key && !player_api_key.expired?
				sign_in_api_key(player_api_key)
		        return true
			else
				return false
			end
		end
	end

	def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render_error(:not_authenticated)
      return false
    end

	def sign_in_api_key(player_api_key)
		sign_in player_api_key.player, store: false
		player_api_key.postpone_expiry!
		@current_api_key = player_api_key
	end

	def current_api_key
		@current_api_key
	end

	# == Errors ==

	def render_error(key, data = nil)
		error = ApiError.get(key)
		render partial: 'api/v1/shared/errors', locals: {error_code: key, message: error[:message], data: data }, status: error[:status]
	end

	# == Filters == 

	def verify_complete_player_registration
		unless current_player.registration_complete?
			render_error(:incomplete_registration)
		end
	end

end
