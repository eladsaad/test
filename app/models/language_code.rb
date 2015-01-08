# == Schema Information
#
# Table name: language_codes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LanguageCode < ActiveRecord::Base
  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :code, :presence => true

  def label
  	"#{self.name} (#{self.code})"
  end
  
end
