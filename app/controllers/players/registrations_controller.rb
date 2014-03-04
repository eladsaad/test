class Players::RegistrationsController < Devise::RegistrationsController
	
	before_filter :configure_permitted_parameters

	before_filter :verify_reg_code, only: [:create, :pre_sign_up]
	after_filter :add_group_from_reg_code, only: [:create]

  respond_to :html, :js

	def pre_sign_up
    respond_to do |format|
      if params[:facebook]
        format.html { redirect_to omniauth_authorize_path(:player, :facebook, reg_code: params[:reg_code]) }
        format.js { render action: 'facebook_redirect' }
      else
        format.html { redirect_to new_player_registration_path(reg_code: params[:reg_code]) }
        format.js { redirect_to new_player_registration_path(reg_code: params[:reg_code]) }
      end
    end
	end

  	protected

  		def verify_reg_code
        group = PlayerGroup.find_by_reg_code(params[:reg_code])
        if group.nil? || !group.active?
          redirect_to :back, alert: t(:invalid_registration_code)
        end
      end

      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:account_update) << [:username, :email, :first_name, :last_name, :birth_date, :gender, :age]

        devise_parameter_sanitizer.for(:sign_up) << [
          :username,
          :email,
          :first_name,
          :last_name,
          :birth_date,
          :gender,
          :age,
          :reg_code,
          :tos_accepted,
          :player_group_association_attributes => [
              :player_group_id
            ],
        ]

      end

      def add_group_from_reg_code
        # assign to group after player creation
        if self.resource.persisted? # player is created successfuly
          group = PlayerGroup.find_by_reg_code(params[:reg_code])
          player_group_association = PlayerGroupAssociation.create(
            player_id: resource.id,
            player_group_id: group.id)
        end
      end

      #def after_inactive_sign_up_path_for(resource)
      #  new_player_session_path
      #end

end