class Player < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :username, :presence => true, :uniqueness => true
	validates :email, :uniqueness => true, :format => {with: /@/}
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :birth_date, :presence => true

	# == DEVISE ==
	devise :database_authenticatable, :registerable, :confirmable,
		   :recoverable, :rememberable, :validatable,
		   :authentication_keys => [:username]

	# == UTILS ==

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

end
