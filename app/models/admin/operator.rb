# == Schema Information
#
# Table name: operators
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  country                :string(255)
#  reg_code_prefix        :string(2)
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
#  last_reg_code_id       :integer
#  disabled               :boolean          default(FALSE)
#

class Admin::Operator < Operator
end
