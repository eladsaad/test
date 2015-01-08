# == Schema Information
#
# Table name: system_admins
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  super_admin            :boolean
#

class Admin::SystemAdmin < SystemAdmin
end
