class Api::V1::RegistrationCodesController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:verify]
	skip_before_filter :verify_complete_player_registration, only: [:verify]
	skip_authorization_check :only => [:verify]

	def verify
		reg_code = params.require(:reg_code)
		if reg_code.blank? || !RegistrationCode.valid_for_registration?(reg_code)
			render_error(:unprocessable_entity, { reg_code: I18n.translate(:is_invalid) })
		end
	end

end