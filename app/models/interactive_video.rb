# == Schema Information
#
# Table name: interactive_videos
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  content                :text
#  language_code_id       :integer
#  description            :text
#  created_at             :datetime
#  updated_at             :datetime
#  content_mobile         :text
#  thumbnail_url          :text
#  thumbnail_disabled_url :text
#

class InteractiveVideo < ActiveRecord::Base

  DYNAMIC_PARAMETER_REGEX = /{{(.*?)}}/

  # == ASSOCIATIONS ==
  belongs_to :language_code

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true
  validate :validate_content

  def validate_content
    if (content.blank? && content_mobile.blank?)
        errors.add(:content, I18n.translate(:missing_content_or_mobile_content))
        errors.add(:content_mobile, I18n.translate(:missing_content_or_mobile_content))
    end
  end

  # == SEARCH ==
  search_columns [:name, :language_code]

  # == UTILS ==
  def index_in_program(online_program)
  	online_program.online_program_interactive_videos.order(:start_after_days, :start_time).pluck(:interactive_video_id).index(self.id)+1
  end

  def allowed_for_player?(player)
    program_video = player.current_online_program.online_program_interactive_videos.find_by_interactive_video_id(self.id)
    return false if program_video.nil?
    program_video.enabled_for_player?(player)
  end

  def self.parse_text(text, player)
    text.gsub(DYNAMIC_PARAMETER_REGEX) do |match|
      player.try(:send, "#{$1}".strip) #TODO: restrict only certain methods ?
    end
  end

end
