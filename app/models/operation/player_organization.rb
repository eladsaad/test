# == Schema Information
#
# Table name: player_organizations
#
#  id               :integer          not null, primary key
#  org_type         :string(255)
#  name             :string(255)
#  address          :text
#  contact_name     :string(255)
#  contact_position :string(255)
#  contact_email    :string(255)
#  contact_phone    :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  operator_id      :integer
#  deleted_at       :datetime
#

class Operation::PlayerOrganization < PlayerOrganization
end
