class PlayerOrganization < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :contact_email, :format => {with: /@/}
	validates :operator_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :operator

	# == SEARCH ==
	def self.search(search)
		if search
			where('name LIKE ? or contact_email LIKE ?', "%#{search}%", "%#{search}%")
		else
			scoped
		end
	end

end
