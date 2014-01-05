class Player < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :username, :presence => true, :uniqueness => true
	#validates :email, :uniqueness => true, :format => {with: /@/}
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :birth_date, :presence => true

	# == ASSOCIATIONS ==
	has_many :player_sessions
	has_many :player_authentications

	# == DEVISE Authentication ==
	devise :database_authenticatable, :registerable, :confirmable,
		   :recoverable, :rememberable, :validatable, :omniauthable,
		   :omniauth_providers => [:facebook],
		   :authentication_keys => [:username]

	# == CANCAN Authorization ==
	def ability
		@ability ||= PlayerAbility.new(self)
	end
	delegate :can?, :cannot?, :to => :ability


	# == UTILS ==

	def full_name
		"#{self.first_name} #{self.last_name}"
	end


	# == FACEBOOK ==

	def copy_missing_data_from_facebook_oauth(auth)
		self.email = auth['extra']['raw_info'].email if self.email.blank?
		self.username = auth['extra']['raw_info'].email if self.username.blank?
	 	self.first_name = auth['extra']['raw_info'].first_name if self.first_name.blank?
	 	self.last_name = auth['extra']['raw_info'].last_name if self.last_name.blank?
 	end


	def self.find_for_facebook_oauth(auth, signed_in_player=nil)

		authentication = PlayerAuthentication.find_by_provider_and_uid(auth.provider, auth.uid)
		
		# facebook authentication already exists in db
		if authentication
			return authentication.player

		# player exists without facebook authentication
		elsif signed_in_player
		 
			signed_in_player.player_authentications.create!(
				:provider => auth.provider,
				:uid => auth.uid,
				:token => auth.credentials.token,
				:token_secret => auth.credentials.secret
			)

			signed_in_player.copy_missing_data_from_facebook_oauth(auth)
			signed_in_player.save! if signed_in_player.changed?

			return signed_in_player

		# unknown player registering via facebook
		else
			return nil
		end
	end


	def self.new_with_session(params, session)
	    super.tap do |player|
	      if session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	        player.copy_missing_data_from_facebook_oauth(session["devise.facebook_data"])
	      end
	    end
	  end

end
