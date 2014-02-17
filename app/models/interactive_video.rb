class InteractiveVideo < ActiveRecord::Base
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
  	online_program.online_program_interactive_videos.pluck(:id).order(:start_after_days).index(self.id)+1
  end


end
