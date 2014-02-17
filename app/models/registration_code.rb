class RegistrationCode < ActiveRecord::Base

	def self.fetch(amount, greater_than_id = 0)
		greater_than_id = 0 if greater_than_id.blank?
		RegistrationCode.where("id > ?", greater_than_id).order(:id).limit(amount)
	end

end
