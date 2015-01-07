# == Schema Information
#
# Table name: system_admins
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  super_admin            :boolean
#

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

	# == SEARCH ==
	search_columns [:email, :first_name, :last_name]

end
