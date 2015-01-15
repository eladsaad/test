# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  language_code_id :integer
#  question         :text
#  answers          :text
#  correct_answer   :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Question < ActiveRecord::Base
  # == ASSOCIATIONS ==
  belongs_to :language_code
  has_and_belongs_to_many :surveys
  has_many :player_answers

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
