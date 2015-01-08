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

class Admin::Video < Video
end
