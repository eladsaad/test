# == Schema Information
#
# Table name: campaign_operator_programs
#
#  id                :integer          not null, primary key
#  campaign_id       :integer
#  operator_id       :integer
#  online_program_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

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
