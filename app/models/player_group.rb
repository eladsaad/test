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

	# == SEARCH ==
	def self.search(search)
		if search
			where('name LIKE ? or description LIKE ? or reg_code LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
		else
			scoped
		end
	end

end
