class SystemAdmin < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :email, :presence => true, :uniqueness => true, :format => {with: /@/}
	validates :first_name, :presence => true
	validates :last_name, :presence => true

end
