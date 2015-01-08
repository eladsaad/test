# == Schema Information
#
# Table name: operator_mobile_stations
#
#  id          :integer          not null, primary key
#  operator_id :integer
#  code        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Operation::OperatorMobileStation < OperatorMobileStation
end
