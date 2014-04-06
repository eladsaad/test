class OnlineProgramInteractiveVideo < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :online_program, :presence => true
	validates :interactive_video_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :online_program
	belongs_to :interactive_video
	belongs_to :pre_survey, foreign_key: :pre_survey_id, class_name: Survey
	belongs_to :post_survey, foreign_key: :post_survey_id, class_name: Survey

  def self.interactive_available_time(online_program_id, interactive_video_id, screening_date)
    video_program_data = self.where('online_program_id = ? and interactive_video_id = ?',
                                                             online_program_id,
                                                             interactive_video_id).first

    #puts '>>>>>' + current_player_group.screening_date.strftime('%a %b %d %H:%M:%S %Z %Y')
    start_time = video_program_data.start_time
    start_after_days =  video_program_data.start_after_days
    opening_time = (screening_date + start_after_days.days) + start_time.hour.hours +
        start_time.min.minutes + start_time.sec.seconds
  end

end
