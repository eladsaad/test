# == Schema Information
#
# Table name: player_api_keys
#
#  id           :integer          not null, primary key
#  access_token :string(255)
#  expires_at   :datetime
#  player_id    :integer
#  active       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class PlayerApiKey < ActiveRecord::Base

	before_create :generate_access_token
	before_create :init_expiration
	belongs_to :player

	def expired?
		DateTime.now >= self.expires_at
	end

	def postpone_expiry!
		self.expires_at = DateTime.now + 1.hour
		self.save!
	end

	private

	def generate_access_token
		begin
			self.access_token = SecureRandom.hex
		end while self.class.exists?(access_token: access_token)
	end

	def init_expiration
		self.expires_at = DateTime.now + 1.hour
	end

	

end
