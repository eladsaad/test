class PlayerOrganization < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :contact_email, :format => {with: /@/}
	validates :operator_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator
	has_one :extension_params, :class_name => "PlayerOrganizationExt", dependent: :destroy
	accepts_nested_attributes_for :extension_params


	# == SEARCH ==
	search_columns [:name, :contact_email]

end
