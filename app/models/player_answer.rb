class PlayerAnswer < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :player_group_id, :presence => true
	validates :survey_id, :presence => true
  	validates :question_id, :presence => true
	validate :player_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :player_group
	belongs_to :player
	belongs_to :survey
	belongs_to :question

	# == UTILS ==

	def self.find_by_player_and_survey_id(player, survey_id)
		self.where(
			player_id: player.id,
			player_group_id: player.current_player_group.id,
			survey_id: survey_id
		)
	end

end
