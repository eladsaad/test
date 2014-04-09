class Api::BaseApiController < ApplicationController

  layout 'layouts/base_api'

  protect_from_forgery with: :null_session

  before_filter :authenticate_player_by_api_key!
  # before_filter :verify_complete_player_registration

  respond_to :json

  def current_ability
  	current_player.ability
  end

  # rescue_from CanCan::AccessDenied, :with => { render :json => 'Access Denied', :status => 403 }
  rescue_from CanCan::AccessDenied do |exception|
  	Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
  	render :json => 'Access Denied', :status => 403
  end

	
  protected 

  	def authenticate_player_by_api_key!
		authenticate_or_request_with_http_token do |token, options|
			player_api_key = PlayerApiKey.where(access_token: token).first
			if player_api_key && !player_api_key.expired?
				sign_in player_api_key.player, store: false
				@current_api_key = player_api_key
		        true
			else
				render_error(:not_authenticated)
				return false
			end
		end
	end

	def verify_complete_player_registration
		unless current_player.registration_complete?
			render_error(:incomplete_registration)
		end
	end

	def current_api_key
		@current_api_key
	end

	def render_error(key)
		error = ApiError.get(key)
		render json: { error: { key: key, message: error[:message] } }, status: error[:status]
	end

end
