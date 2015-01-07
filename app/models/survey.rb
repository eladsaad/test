# == Schema Information
#
# Table name: surveys
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  language_code_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Survey < ActiveRecord::Base
  
  # == ASSOCIATIONS ==
  belongs_to :language_code
  has_and_belongs_to_many :questions
  has_many :questions_surveys, :inverse_of => :survey, :dependent => :destroy
  accepts_nested_attributes_for :questions_surveys, allow_destroy: true, reject_if: :all_blank

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true

  # == SEARCH ==
  search_columns [:name, :language_code]

  # == EXTERNAL SURVEY ID ==
  # This is needed so that the same survey id can be used as a pre/post survey for different interactive
  # videos and online programs, and still be identified uniquely in player's answers.

  def self.encode_external_id(survey_id, online_program_interactive_video_id, pre_post)
    return nil if survey_id.blank?
    return [survey_id, online_program_interactive_video_id, pre_post].join('_')
  end

  # returns array [survey_id, online_program_interactive_video_id, pre_post] 
  def self.decode_external_id(external_id)
    return external_id.split('_')
  end

  def self.find_by_external_id(external_id)
    survey_id = self.decode_external_id(external_id).first
    find(survey_id)
  end

  def allowed_for_player?(player)
    allowed_survey_ids = player.current_online_program.online_program_interactive_videos.pluck(:pre_survey_id, :post_survey_id).flatten
    allowed_survey_ids.include?(self.id)
  end


end
