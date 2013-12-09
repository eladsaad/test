class Operator < ActiveRecord::Base
  
	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => {with: /@/}
	validates :country, :presence => true
	validates :reg_code_prefix, :presence => true, :length => {is: 2}

	# == ASSOCIATIONS ==
	has_many :player_groups
	has_many :player_organizations

	# == DEVISE ==
	devise :database_authenticatable, :confirmable,
		   :recoverable, :rememberable, :validatable,
		   :authentication_keys => [:email]

end
