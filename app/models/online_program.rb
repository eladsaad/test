class OnlineProgram < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :codename, :presence => true, :uniqueness => true

	# == ASSOCIATIONS ==
	has_many :online_program_interactive_videos, -> { order 'start_after_days ASC, start_time ASC' }, :inverse_of => :online_program, :dependent => :destroy
  	has_many :interactive_videos, through: :online_program_interactive_videos
	accepts_nested_attributes_for :online_program_interactive_videos, allow_destroy: true, reject_if: :all_blank

	has_many :online_program_notifications, -> { order 'start_after_days ASC, start_time ASC' }, :inverse_of => :online_program, :dependent => :destroy
	accepts_nested_attributes_for :online_program_notifications, allow_destroy: true, reject_if: :all_blank

	belongs_to :background_image, foreign_key: :background_image_id, class_name: Image

	belongs_to :promo_video, foreign_key: :promo_video_id, class_name: Video

	belongs_to :language_code

	belongs_to :sign_up_survey, foreign_key: :sign_up_survey_id, class_name: Survey

	has_and_belongs_to_many :operators

	# == SEARCH ==
	search_columns [:name, :codename]

	# == UTILS ==

	def enabled_interactive_videos(player_group)
		days_since_start = (Date.today - player_group.screening_date).to_i
		current_time = Time.now.strftime("%H:%M:%S")
		self.online_program_interactive_videos.where('start_after_days < ? or (start_after_days = ? and start_time <= ?)', days_since_start, days_since_start, current_time)
	end

	def enabled_notifications(player_group)
		days_since_start = (Date.today - player_group.screening_date).to_i
		current_time = Time.now.strftime("%H:%M:%S")
		self.online_program_notifications.where('start_after_days < ? or (start_after_days = ? and start_time <= ?)', days_since_start, days_since_start, current_time)
	end
	
end
