class OnlineProgram < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :codename, :presence => true, :uniqueness => true

	# == ASSOCIATIONS ==
	has_many :online_program_videos, :inverse_of => :online_program, :dependent => :destroy
	accepts_nested_attributes_for :online_program_videos, allow_destroy: true, reject_if: :all_blank

	has_many :online_program_notifications, :inverse_of => :online_program, :dependent => :destroy
	accepts_nested_attributes_for :online_program_notifications, allow_destroy: true, reject_if: :all_blank

	belongs_to :background_image, foreign_key: :background_image_id, class_name: Image

	belongs_to :promo_video, foreign_key: :promo_video_id, class_name: Video

	belongs_to :language_code

	# == SEARCH ==
	search_columns [:name, :codename]
	
end
