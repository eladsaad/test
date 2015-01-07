# == Schema Information
#
# Table name: videos
#
#  id               :integer          not null, primary key
#  url              :string(255)
#  thumbnail_url    :string(255)
#  name             :string(255)
#  language_code_id :integer
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#

class Video < ActiveRecord::Base
  # == ASSOCIATIONS ==
  belongs_to :language_code

  # == VALIDATIONS ==
  validates :name, :presence => true
  validates :language_code_id, :presence => true
  validates :url, :presence => true

  # == SEARCH ==
  search_columns [:name, :language_code, :title]
end
