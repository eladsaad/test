class PlayerGroup < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :operator_id, :presence => true
	validates :reg_code, :presence => true, :uniqueness => true
	validate :validate_reg_code_with_operator, :on => :create
	validates :screening_date, :presence => true
	validates :name, :presence => true
	validates :player_organization_id, :presence => true
	validate :validate_allowed_online_program

	# == ASSOCIATIONS ==
	belongs_to :operator
	belongs_to :player_organization
	belongs_to :online_program
	has_and_belongs_to_many :players, join_table: :player_group_associations
	has_one :extension_params, :class_name => "PlayerGroupExt", dependent: :destroy
	accepts_nested_attributes_for :extension_params

	# == SEARCH ==
	search_columns [:name, :description, :reg_code, :mobile_station_code]

	# == SETTINGS ==
	attr_readonly :reg_code

	# == SOFT DELETE ==
	has_soft_delete

	# == UTILS ==

	def allowed_online_programs
		self.operator.online_programs
	end

	private

		def validate_reg_code_with_operator
			errors.add(:reg_code, I18n.translate(:is_invalid)) unless self.operator.valid_code?(self.reg_code)			
		end

		def validate_allowed_online_program
			errors.add(:online_program, I18n.translate(:is_not_allowed)) unless self.allowed_online_programs.pluck(:id).include?(self.online_program_id)
		end

end

