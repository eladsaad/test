class Players::ConfirmationsController < Devise::ConfirmationsController

  protected
    def after_confirmation_path_for(resource_name, resource)
      '/players/sign_in'
    end
end