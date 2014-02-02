class LanguageCode < ActiveRecord::Base
  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :code, :presence => true
end
