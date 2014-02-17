class Player < ActiveRecord::Base

	# == VALIDATIONS ==
	#validates :username, :presence => true, :uniqueness => true
	#validates :email, :uniqueness => true, :format => {with: /@/}
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	#validates :gender, :inclusion => { :in => ['male', 'female'] }

	# == ASSOCIATIONS ==
	has_many :player_sessions
	has_many :player_authentications
	has_and_belongs_to_many :player_groups, join_table: :player_group_associations

	# == DEVISE Authentication ==
	devise :database_authenticatable, :registerable, :confirmable,
	:recoverable, :rememberable, :validatable, :omniauthable,
	:omniauth_providers => [:facebook],
	:authentication_keys => [:email]

	# == CANCAN Authorization ==
	def ability
		@ability ||= PlayerAbility.new(self)
	end
	delegate :can?, :cannot?, :to => :ability


	# == UTILS ==

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def current_player_group
		self.player_groups.last
	end

	def current_online_program
		self.current_player_group.online_program
	end

	# == FACEBOOK ==

	def get_token(provider)
		self.player_authentications.find_by_provider(provider).try(:token)
	end

	def copy_missing_data_from_facebook_oauth(auth)
		self.email = auth.extra.raw_info.try(:email) if self.email.blank?
		self.username = auth.extra.raw_info.try(:email) if self.username.blank?
		self.first_name = auth.extra.raw_info.try(:first_name) if self.first_name.blank?
		self.last_name = auth.extra.raw_info.try(:last_name) if self.last_name.blank?
		self.gender = auth.extra.raw_info.try(:gender).try(:downcase) if self.gender.blank?
		self.birth_date = Date.strptime(auth.extra.raw_info.try(:birthday), '%m/%d/%Y') if self.birth_date.blank?
		self.profile_picture = auth.info.try(:image) if self.profile_picture.blank?
	end


	def self.find_for_facebook_oauth(auth, signed_in_player=nil)
		authentication = PlayerAuthentication.find_by_provider_and_uid(auth.provider, auth.uid)
		
		# facebook authentication already exists in db
		if authentication
			# update authentication token
			if auth.credentials.token && auth.credentials.token != authentication.token
		   		authentication.update_attribute(:token, auth.credentials.token)
		 	end
		 	authentication.player.copy_missing_data_from_facebook_oauth(auth)
		 	authentication.player.save! if authentication.player.changed?

			return authentication.player
		
		# player exists without facebook authentication
		elsif signed_in_player
			signed_in_player.player_authentications.build(
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
			# create a new player
			player = Player.new_from_omni_auth(auth)
			player.copy_missing_data_from_facebook_oauth(auth)
			player.password = Devise.friendly_token.first(8) # random password
			player.skip_confirmation!
			player.save
			return player
		end
	end


	def self.new_from_omni_auth(auth)
		player = Player.new
		player.player_authentications.build(
			:provider => auth.provider,
			:uid => auth.uid,
			:token => auth.credentials.token,
			:token_secret => auth.credentials.secret
		)
		return player
	end


	def self.new_with_session(params, session)
		super.tap do |player|
			if session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				player.copy_missing_data_from_facebook_oauth(session["devise.facebook_data"])
			end
		end
	end

	def send_facebook_notifications(message, callback_url)
		facebook_user_id = self.player_authentications.find_by_provider(:facebook).try(:uid)
		return nil if facebook_user_id.nil?

		uri = URI.encode("https://graph.facebook.com/#{facebook_user_id}/notifications")
		uri = URI.parse(uri)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		fb_req = Net::HTTP::Post.new(uri.request_uri)
		fb_req.set_form_data(
			'access_token' => ENV['FACEBOOK_APP_ACCESS_TOKEN'],
			'href' => callback_url,
			'template' => message,
			)

		http.request(fb_req) # return response
	end

end
