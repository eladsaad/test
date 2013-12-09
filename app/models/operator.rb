class Operator < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => {with: /@/}
	validates :country, :presence => true
	validates :reg_code_prefix, :presence => true, :length => {is: 2}

end
