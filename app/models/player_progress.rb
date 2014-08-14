class PlayerProgress < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :player_id, :presence => true
	validates :last_interactive_video_index, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :player

end
