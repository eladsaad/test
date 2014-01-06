class PlayerOrganization < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :contact_email, :format => {with: /@/}
	validates :operator_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator

	# == SEARCH ==
	search_columns [:name, :contact_email]

end
