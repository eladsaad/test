class PlayerScoreUpdate < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :player

	# == SETTINGS ==
 	serialize :data

	# == HOOKS ==
	before_create :set_points_if_missing
	after_create :update_player_score

 	def set_points_if_missing
 		self.points ||= AppSettings.player_score_update_points[self.event]
	end

 	def update_player_score
 		score = Score.where(player_group_id: self.player.current_player_group.id, player_id: self.player.id).first_or_initialize
		score.score ||= 0
		score.score += self.points
		score.save!
	end

	# == UTILS ==

	def message
		I18n.t("score_updates.#{self.event}", self.data.merge({points: self.points}))
	end

	def self.unreported(player_id)
		self.where(player_id: player_id, reported: false)
	end

	def self.mark_reported!(player_score_updates)
		player_score_updates.update_all(reported: true) if player_score_updates.any?
	end

end
