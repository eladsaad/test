class PlayerAnswer < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :player_group_id, :presence => true
	validates :external_survey_id, :presence => true
  	validates :question_id, :presence => true
	validates :player_id, :presence => true
	validates :answer_number, :presence => true
	validate :validate_answer_number
	validate :validate_question_in_survey

	# == ASSOCIATIONS ==
	belongs_to :player_group
	belongs_to :player
	belongs_to :question


	# == EXTERNAL SURVEY IDS ==
	# See "Survey" model for details

	def real_survey_id
		Survey.decode_external_id(self.external_survey_id).first
	end

	# == UTILS ==

	def self.find_by_player_and_external_survey_id(player, external_survey_id)
		self.where(
			player_id: player.id,
			player_group_id: player.current_player_group.id,
			external_survey_id: external_survey_id
		)
	end

	# returns array [status (true/false), array of errors]
	def self.save_answers(external_survey_id, player, answers)
		survey = Survey.find_by_external_id(external_survey_id)
		survey_question_ids = survey.questions.pluck(:id)

		player_id = player.id
		player_group_id = player.current_player_group.id

		errors = []
		answers_to_create = []
		answered_question_ids = []

		answers.each_with_index do |answer, index|

			new_answer = PlayerAnswer.new(
				player_group_id: player_group_id,
				player_id: player_id,
				external_survey_id: external_survey_id,
				question_id: answer['question_id'],
				answer_number: answer['answer_number']
			)

			new_answer.valid?
			errors << {question_id: new_answer.question_id, errors: new_answer.errors.full_messages} if new_answer.errors.any?
			
			answered_question_ids << new_answer.question_id
			answers_to_create << new_answer
            
		end

		(survey_question_ids - answered_question_ids).each do |missing_question_id|
			errors << { question_id: missing_question_id, errors: ['Question is missing']}
		end

		if errors.any?
			return [false, errors]
		else
			PlayerAnswer.transaction do
			  answers_to_create.each(&:save)
			end
			player.add_points(:survey_answer, {external_survey_id: external_survey_id} )
			return [true, nil]
		end
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
			if self.external_survey_id.present? && self.question_id.present?
				survey = Survey.find_by_id(self.real_survey_id)
				if (survey.present? && !survey.questions.pluck(:id).include?(self.question_id))
					errors.add(:question_id, I18n.translate(:is_invalid))
				end
			end
		end

end
