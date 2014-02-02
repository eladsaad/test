class OperatorMobileStation < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :code, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator

	# == SEARCH ==
	search_columns [:code]
	
end
