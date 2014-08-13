class Api::V1::SurveysController < Api::BaseApiController

	def show
		@external_survey_id = params.require(:id)
		@survey = Survey.find_by_external_id(@external_survey_id)
		authorize! :read, @survey
	end

end