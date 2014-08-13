if program_video.pre_survey_id.present? || program_video.post_survey_id.present?
	json.surveys do
		if program_video.pre_survey_id.present?
			json.pre_survey do
				json.partial! 'survey', survey_id: program_video.external_pre_survey_id 
			end
		end
		if program_video.post_survey_id.present?
			json.post_survey do
				json.partial! 'survey', survey_id: program_video.external_post_survey_id 
			end
		end
	end
end