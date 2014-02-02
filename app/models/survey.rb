class Survey < ActiveRecord::Base
  # == ASSOCIATIONS ==
  belongs_to :language_code
  has_and_belongs_to_many :questions

  # == FIELD SETTINGS ==
  serialize :question_ids, JSON

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true

  # == SEARCH ==
  search_columns [:name, :language_code]
end