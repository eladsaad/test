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

class Admin::Question < Question
end
