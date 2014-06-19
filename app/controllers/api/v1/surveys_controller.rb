class Api::V1::SurveysController < Api::BaseApiController

	def show
		@survey = Survey.find(params.require(:id))
		authorize! :read, @survey
	end

end