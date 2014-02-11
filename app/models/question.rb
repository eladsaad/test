class Question < ActiveRecord::Base
  # == ASSOCIATIONS ==
  belongs_to :language_code
  has_and_belongs_to_many :surveys

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true
  validates :question, :presence => true
  validates :answers, :presence => true

  # == SETTINGS ==
  serialize :answers

  # == SEARCH ==
  search_columns [:name, :language_code, :question]
end
