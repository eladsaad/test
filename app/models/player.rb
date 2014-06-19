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
			errors.add(:reg_code, I18n.translate(:is_invalid))
		end
	end

	def validate_has_group
		Rails.logger.info "DOR #{self.reg_code}"
		unless self.player_group_associations.any?
			errors.add(:reg_code, I18n.translate(:is_invalid))
		end
	end


	# == HOOKS ==
	before_validation :assign_group_from_reg_code

	def assign_group_from_reg_code
		if !self.reg_code.blank? && !self.current_player_group.present?
			group = PlayerGroup.find_by_reg_code(self.reg_code)
      if group.nil?
        render status: :not_acceptable
      end
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


	def self.find_for_facebook_oauth(auth, signed_in_player=nil, reg_code=nil)
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
			player = Player.new
			player.add_authentication_from_omni_auth(auth)
			player.copy_missing_data_from_facebook_oauth(auth)
			player.password = Devise.friendly_token.first(8)
			player.skip_confirmation!
			if !reg_code.nil?
				group = PlayerGroup.find_by_reg_code(reg_code)
				player.player_group_associations.build(player_group_id: group.id)
			end
			player.save(validate: false)
			return player
		end
	end

	def add_authentication_from_omni_auth(auth)
		self.player_authentications.build(
			:provider => auth.provider,
			:uid => auth.uid,
			:token => auth.credentials.token,
			:token_secret => auth.credentials.secret
		)
	end


	def self.new_with_session(params, session)
		super.tap do |player|
			if session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				player.add_authentication_from_omni_auth(session["devise.facebook_data"])
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

  def invite_friend(friend_email, message)
    PlayerMailer.invite_email(friend_email,
                              self.first_name,
                              message).deliver

    add_points(2500)
  end


	# == Scores ==

	def add_points(points, player_group_id = self.current_player_group.id)
		score = Score.where(player_group_id: player_group_id, player_id: self.id).first_or_initialize
		score.score ||= 0
		score.score += points
		score.save!

    points
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

	

end
