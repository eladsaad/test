class SystemAdmin < ActiveRecord::Base
  
	# == VALIDATIONS ==
	validates :email, :presence => true, :uniqueness => true, :format => {with: /@/}
	validates :first_name, :presence => true
	validates :last_name, :presence => true

	# == DEVISE Authentication ==
	devise :database_authenticatable, :confirmable,
		   :recoverable, :rememberable, :validatable,
		   :authentication_keys => [:email]


	# == CANCAN Authorization ==
	def ability
		@ability ||= Admin::SystemAdminAbility.new(self)
	end
	delegate :can?, :cannot?, :to => :ability

	# == UTILS ==

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

end
