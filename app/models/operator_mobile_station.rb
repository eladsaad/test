# == Schema Information
#
# Table name: operator_mobile_stations
#
#  id          :integer          not null, primary key
#  operator_id :integer
#  code        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class OperatorMobileStation < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :code, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator

	# == SEARCH ==
	search_columns [:code]
	
end
