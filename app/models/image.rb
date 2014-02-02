class Image < ActiveRecord::Base

  # == VALIDATIONS ==
  validates :url, :presence => true

  # == SEARCH ==
  search_columns [:name, :url, :format]
end
