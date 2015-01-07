# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  language_code_id :integer
#  description      :text
#  title            :text
#  facebook_content :text
#  email_content    :text
#  created_at       :datetime
#  updated_at       :datetime
#  language_code    :integer
#

class Admin::Notification < Notification
end
