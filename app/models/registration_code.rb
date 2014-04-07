class RegistrationCode < ActiveRecord::Base

	def self.fetch(amount, greater_than_id = 0)
		greater_than_id = 0 if greater_than_id.blank?
		RegistrationCode.where("id > ?", greater_than_id).order(:id).limit(amount)
	end

	def self.valid_for_registration?(code)
		group = nil
		group = PlayerGroup.find_by_reg_code(code) unless code.blank?
		return (!group.nil? && group.active?)
	end

end
