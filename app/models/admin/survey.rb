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

class Admin::Survey < Survey
end
