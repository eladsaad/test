# == Schema Information
#
# Table name: online_programs
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  codename            :string(255)
#  language_code_id    :integer
#  description         :text
#  background_image_id :integer
#  promo_video_id      :integer
#  created_at          :datetime
#  updated_at          :datetime
#  sign_up_survey_id   :integer
#

class Admin::OnlineProgram < OnlineProgram
end
