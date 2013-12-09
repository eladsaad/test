class Player < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :username, :presence => true, :uniqueness => true
	validates :email, :presence => true, :uniqueness => true, :format => {with: /@/}
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :birth_date, :presence => true

end
