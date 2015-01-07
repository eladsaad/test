# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  url           :string(255)
#  thumbnail_url :string(255)
#  name          :string(255)
#  description   :text
#  format        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Image < ActiveRecord::Base

  # == VALIDATIONS ==
  validates :url, :presence => true

  # == SEARCH ==
  search_columns [:name, :url, :format]
end
