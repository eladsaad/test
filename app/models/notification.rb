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
			player.try(:send, "#{$1}".strip)
		end
	end

end
