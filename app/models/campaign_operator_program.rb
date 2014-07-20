class CampaignOperatorProgram < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :campaign, :presence => true
	validates :operator_id, :presence => true
	validates :online_program_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :campaign
	belongs_to :operator
	belongs_to :online_program
end
