class Api::V1::SurveysController < Api::BaseApiController

	def show
		@survey = Survey.find(params[:id])
		authorize! :read, @survey
	end

	def create
		# TODO: add strong parameters
	end

end