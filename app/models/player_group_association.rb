class PlayerGroupAssociation < ActiveRecord::Base
	
  	# == VALIDATIONS ==
	validates :player_id, :presence => true
	validates :player_group_id, :presence => true

end
