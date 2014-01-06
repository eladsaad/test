class PlayerGroup < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :operator_id, :presence => true
	validates :reg_code, :presence => true, :uniqueness => true
	validates :program_start_date, :presence => true
	validates :name, :presence => true
	validates :player_organization_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator
	belongs_to :player_organization
	has_and_belongs_to_many :players, join_table: :player_group_associations
	has_one :extension_params, :class_name => "PlayerGroupExt", dependent: :destroy
	accepts_nested_attributes_for :extension_params

	# == SEARCH ==
	search_columns [:name, :description, :reg_code]

end
