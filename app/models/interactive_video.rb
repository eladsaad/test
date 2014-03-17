class InteractiveVideo < ActiveRecord::Base

  DYNAMIC_PARAMETER_REGEX = /{{(.*?)}}/

  # == ASSOCIATIONS ==
  belongs_to :language_code

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true
  validates :content, :presence => true

  # == SEARCH ==
  search_columns [:name, :language_code]

  # == UTILS ==
  def index_in_program(online_program)
  	online_program.online_program_interactive_videos.order(:start_after_days).pluck(:interactive_video_id).index(self.id)+1
  end

  def self.parse_text(text, player)
    text.gsub(DYNAMIC_PARAMETER_REGEX) do |match|
      player.try(:send, "#{$1}".strip)
    end
  end

end
