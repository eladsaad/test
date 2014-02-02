class LanguageCode < ActiveRecord::Base
  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :code, :presence => true

  def label
  	"#{self.name} (#{self.code})"
  end
  
end
