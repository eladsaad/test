class Video < ActiveRecord::Base
  # == ASSOCIATIONS ==
  belongs_to :language_code

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true
  validates :url, :presence => true

  # == SEARCH ==
  search_columns [:name, :language_code, :title]
end
