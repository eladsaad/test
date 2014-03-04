class Players::ConfirmationsController < Devise::ConfirmationsController
  respond_to :html, :js
  
  protected
    def after_confirmation_path_for(resource_name, resource)
    	new_player_session_path
    end
end