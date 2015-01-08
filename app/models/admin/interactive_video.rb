# == Schema Information
#
# Table name: interactive_videos
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  content                :text
#  language_code_id       :integer
#  description            :text
#  created_at             :datetime
#  updated_at             :datetime
#  content_mobile         :text
#  thumbnail_url          :text
#  thumbnail_disabled_url :text
#

class Admin::InteractiveVideo < InteractiveVideo
end
