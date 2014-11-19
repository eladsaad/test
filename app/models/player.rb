class Player < ActiveRecord::Base

	# == VIRTUAL ATTRIBUTES ==
	attr_accessor :reg_code
	attr_accessor :allow_facebook_signup_without_reg_code
	attr_accessor :skip_tos_validation

	# == VALIDATIONS ==
	validates :first_name, :presence => true
  	validates :tos_accepted, :acceptance => {:accept => true}, :unless => :skip_tos_validation
  	validate :validate_has_group, :unless => :allow_facebook_signup_without_reg_code
	validate :validate_reg_code, :unless => :allow_facebook_signup_without_reg_code

	def validate_has_group
		unless self.player_group.present?
			errors.add(:reg_code, I18n.translate(:is_invalid)) unless errors[:reg_code].present?
		end
	end

	def validate_reg_code
		if !self.reg_code.blank? && !RegistrationCode.valid_for_registration?(self.reg_code)
			errors.add(:reg_code, I18n.translate(:is_invalid)) unless errors[:reg_code].present?
		end
	end

	# == HOOKS ==
	before_validation :assign_group_from_reg_code
	after_update :delete_api_keys_on_password_change
	after_create :add_points_to_inviters

	def assign_group_from_reg_code
		if !self.reg_code.blank? && !self.player_group.present? && RegistrationCode.valid_for_registration?(self.reg_code)
			group = PlayerGroup.find_by_reg_code(self.reg_code)
			self.player_group_id = group.id
		end
	end

	def delete_api_keys_on_password_change
		self.player_api_keys.destroy_all if self.encrypted_password_changed?
	end

	def add_points_to_inviters
		PlayerInvite.player_registered!(self)
	end


	# == ASSOCIATIONS ==
	belongs_to :player_group
	has_one :player_progress
	has_many :player_sessions, :dependent => :destroy
	has_many :player_api_keys, :dependent => :destroy
	has_many :player_score_updates, :dependent => :destroy
	has_many :player_authentications, :dependent => :destroy
  	has_many :player_answers, :dependent => :destroy
  	has_many :player_invites, :foreign_key => 'inviting_player_id', :dependent => :destroy

	# == DEVISE Authentication ==
	devise :database_authenticatable, :registerable, :confirmable,
	:recoverable, :rememberable, :validatable, :omniauthable,
	:omniauth_providers => [:facebook],
	:authentication_keys => [:email]

	def confirmation_required?
      false
    end

	# == CANCAN Authorization ==
	def ability
		@ability ||= PlayerAbility.new(self)
	end
	delegate :can?, :cannot?, :to => :ability


	# == UTILS ==

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def current_online_program
		self.player_group.online_program
	end

	def player_progress
		super || build_player_progress
	end

	def group_name
		self.player_group.try(:name)
	end

	def age
		age = read_attribute(:age)
		if age.blank? && !self.birth_date.blank?
			current_date = Time.now.utc.to_date
  			age = current_date.year - self.birth_date.year - (self.birth_date.to_date.change(:year => current_date.year) > current_date ? 1 : 0)
		end
		return age
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
		birthday = auth.extra.raw_info.try(:birthday)
		self.birth_date = Date.strptime(birthday, '%m/%d/%Y') if self.birth_date.blank? && !birthday.blank?
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


	def self.create_for_facebook_oauth(auth, reg_code, tos_accepted = nil)
		player = Player.new
		player.add_authentication_from_omni_auth(auth)
		player.copy_missing_data_from_facebook_oauth(auth)
		player.password = Devise.friendly_token.first(8)
		player.tos_accepted = tos_accepted
		player.reg_code = reg_code
		player.skip_confirmation!		
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

	def add_points(event_key, data = nil)
		score_update = self.player_score_updates.new(
			event: event_key,
			data: data
		)
		score_update.set_points_if_missing
		
		if score_update.points.present? && score_update.points > 0
			score_update.save!
		else
			Rails.logger.info "No points set for event [#{event_key}]"
		end
	end

	def self.add_points(player_id, event_key, data = nil)
		Player.find(player_id).add_points(event_key, data)
	end


	# == Registration ==

	def registration_complete?
		return self.tos_accepted && self.player_group.present?
	end

end