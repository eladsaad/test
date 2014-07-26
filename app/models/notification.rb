class Notification < ActiveRecord::Base

	DYNAMIC_PARAMETER_REGEX = /{{(.*?)}}/

	# == ASSOCIATIONS ==
	belongs_to :language_code

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :language_code_id, :presence => true
	validates :title, :presence => true

	# == SEARCH ==
	search_columns [:name, :language_code, :title]

	def self.parse_text(text, player)
		text.gsub(DYNAMIC_PARAMETER_REGEX) do |match|
			field_name = "#{$1}".strip 
			if ['first_name', 'last_name', 'full_name', 'email', 'birth_date', 'gender', 'age'].include?(field_name)
				player.try(:send, field_name) 
			else
				match
			end
		end
	end

	def allowed_for_player?(player)
		player.current_online_program.enabled_notifications(player.current_player_group).where(notification_id: self.id).any?
	end

end
