class Player < ActiveRecord::Base

	# == VIRTUAL ATTRIBUTES ==
	attr_accessor :reg_code

	# == VALIDATIONS ==
	validates :first_name, :presence => true
	validates :last_name, :presence => true
  	validates :tos_accepted, :acceptance => {:accept => true}
	validate :validate_reg_code
	validate :validate_has_group

	def validate_reg_code
		if !self.reg_code.blank? && !RegistrationCode.valid_for_registration?(self.reg_code)
			errors.add(:reg_code, I18n.translate(:is_invalid)) unless errors[:reg_code].present?
		end
	end

	def validate_has_group
		unless self.player_group_associations.any?
			errors.add(:reg_code, I18n.translate(:is_invalid)) unless errors[:reg_code].present?
		end
	end


	# == HOOKS ==
	before_validation :assign_group_from_reg_code

	def assign_group_from_reg_code
		if !self.reg_code.blank? && !self.current_player_group.present? && RegistrationCode.valid_for_registration?(self.reg_code)
			group = PlayerGroup.find_by_reg_code(self.reg_code)
			result = self.player_group_associations.build(player_group_id: group.id)
		end
	end


	# == ASSOCIATIONS ==
	has_many :player_sessions
	has_many :player_authentications, :dependent => :destroy
	has_many :player_group_associations, :dependent => :destroy
	has_and_belongs_to_many :player_groups, join_table: :player_group_associations
  	has_many :scores
  	has_many :player_answers

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

	def current_progress
		PlayerProgress.find_or_create_by(
	      player_id: self.id,
	      player_group_id: self.current_player_group.id
	    )
	end

	def group_name
		self.current_player_group.try(:name)
	end

	# == SEARCH ==
	search_columns [:email, :first_name, :last_name]

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
			signed_in_player.add_authentication_from_omni_auth(auth)
			signed_in_player.copy_missing_data_from_facebook_oauth(auth)
			signed_in_player.save! if signed_in_player.changed?
			return signed_in_player
		
		# unknown player registering via facebook
		else
			return nil
		end
	end


	def self.create_for_facebook_oauth(auth, reg_code = nil, tos_accepted = nil)
		player = Player.new
		player.add_authentication_from_omni_auth(auth)
		player.copy_missing_data_from_facebook_oauth(auth)
		player.password = Devise.friendly_token.first(8)
		player.tos_accepted = tos_accepted
		player.skip_confirmation!
		player.reg_code = reg_code
		player.assign_group_from_reg_code
		return player
	end


	def add_authentication_from_omni_auth(auth)
		self.player_authentications.build(
			:provider => auth.provider,
			:uid => auth.uid,
			:token => auth.credentials.token,
			:token_secret => auth.credentials.secret
		)
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


	# == Scores ==

	def add_points(points, action_key = nil)
		score = Score.where(player_group_id: self.current_player_group.id, player_id: self.id).first_or_initialize
		score.score ||= 0
		score.score += points
		score.save!
		ScoreUpdate.add(points, action_key)
	end

	def score(player_group_id = nil)
		player_group_id ||= self.current_player_group.try(:id)
		return 0 if player_group_id.blank?
		score = Score.where(player_group_id: player_group_id, player_id: self.id).first_or_initialize
		score.score ||= 0
	end


	# == Registration ==

	def registration_complete?
		return self.tos_accepted && self.current_player_group.present?
	end


	# == Invites ==

	def invite_friend(friend_email, message = '')
		PlayerMailer.custom_email(
			friend_email,
			I18n.t(:player_invited_you_to_join, player_name: self.first_name),
			message
        ).deliver

	    self.add_points(2500, :friend_invite)
	end

end
