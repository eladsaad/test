class PlayerOrganization < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :contact_email, :format => {with: /@/}
	validates :operator_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator

end
