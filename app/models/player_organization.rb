# == Schema Information
#
# Table name: player_organizations
#
#  id               :integer          not null, primary key
#  org_type         :string(255)
#  name             :string(255)
#  address          :text
#  contact_name     :string(255)
#  contact_position :string(255)
#  contact_email    :string(255)
#  contact_phone    :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  operator_id      :integer
#  deleted_at       :datetime
#

class PlayerOrganization < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :operator_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator
	has_one :extension_params, :class_name => "PlayerOrganizationExt", dependent: :destroy
	accepts_nested_attributes_for :extension_params

	# == SEARCH ==
	search_columns [:name, :contact_email]

	# == SOFT DELETE ==
	has_soft_delete

end
