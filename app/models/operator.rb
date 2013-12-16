class Operator < ActiveRecord::Base
  
	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => {with: /@/}
	validates :country, :presence => true
	validates :reg_code_prefix, :presence => true, :length => {is: 2}

	# == ASSOCIATIONS ==
	has_many :player_groups
	has_many :player_organizations

	# == DEVISE Authentication ==
	devise :database_authenticatable, :confirmable,
		   :recoverable, :rememberable, :validatable,
		   :authentication_keys => [:email]

	# == CANCAN Authorization ==
	def ability
		@ability ||= Operation::OperatorAbility.new(self)
	end
	delegate :can?, :cannot?, :to => :ability

	# == Registration Codes ==
	def fetch_registration_codes(amount = 1)
		reg_codes = RegistrationCode.fetch(amount, self.last_reg_code_id)
		self.update({last_reg_code_id: reg_codes.last.id})
		return reg_codes.map { |reg_code| self.reg_code_prefix + reg_code.code }
	end

end
