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
end