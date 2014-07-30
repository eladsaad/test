class Players::SessionsController < Devise::SessionsController
	
	after_filter :add_score_updates_to_flash

	respond_to :html, :js

	def destroy
		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
		respond_to do |format|
			format.html { super }
			format.js  {
				#redirect_to '/', status: 303
			}
		end
	end

	def after_sign_in_path_for(player)
		interactive_videos_path
	end

	def after_sign_out_path_for(player_symbol)
		root_url
	end

end