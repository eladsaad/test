class PlayerAnswer < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :player_group_id, :presence => true
	validates :survey_id, :presence => true
  	validates :question_id, :presence => true
	validates :player_id, :presence => true
	validates :answer_number, :presence => true
	validate :validate_answer_number
	validate :validate_question_in_survey

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


	protected

		def validate_answer_number
			if self.question_id.present? && self.answer_number.present?
				question = Question.find_by_id(self.question_id)
				if (question.present? && !self.answer_number.between?(1, question.answers.length))
					errors.add(:answer_number, I18n.translate(:is_invalid))
				end
			end
		end

		def validate_question_in_survey
			if self.survey_id.present? && self.question_id.present?
				survey = Survey.find_by_id(self.survey_id)
				if (survey.present? && !survey.questions.pluck(:id).include?(self.question_id))
					errors.add(:question_id, I18n.translate(:is_invalid))
				end
			end
		end

end
