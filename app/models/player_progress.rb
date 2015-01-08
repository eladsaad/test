# == Schema Information
#
# Table name: player_progresses
#
#  id                           :integer          not null, primary key
#  player_id                    :integer
#  last_interactive_video_index :integer          default(0)
#  created_at                   :datetime
#  updated_at                   :datetime
#

class PlayerProgress < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :player_id, :presence => true
	validates :last_interactive_video_index, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :player

end
