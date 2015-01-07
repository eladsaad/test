# == Schema Information
#
# Table name: player_groups
#
#  id                     :integer          not null, primary key
#  operator_id            :integer
#  reg_code               :string(255)
#  screening_date         :date
#  name                   :string(255)
#  description            :text
#  player_organization_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#  mobile_station_code    :string(255)
#  deleted_at             :datetime
#  online_program_id      :integer
#

class Operation::PlayerGroup < PlayerGroup
	has_many :players, class_name: 'Operation::Player'
end
