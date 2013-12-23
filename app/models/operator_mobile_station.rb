class OperatorMobileStation < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :operator

	# == SEARCH ==
	def self.search(search)
		if search
			where('code LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
	
end
