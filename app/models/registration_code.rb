class RegistrationCode < ActiveRecord::Base

	def self.fetch(amount, greater_than_id = 0)
		RegistrationCode.where("id > ?", greater_than_id).order(:id).limit(amount)
	end

end
