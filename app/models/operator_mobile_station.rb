class OperatorMobileStation < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :operator

	# == SEARCH ==
	search_columns [:code]
	
end
