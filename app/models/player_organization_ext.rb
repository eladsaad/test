# == Schema Information
#
# Table name: player_organization_exts
#
#  id                     :integer          not null, primary key
#  player_organization_id :integer
#  custom_01              :string(255)
#  custom_02              :string(255)
#  custom_03              :string(255)
#  custom_04              :string(255)
#  custom_05              :string(255)
#  custom_06              :string(255)
#  custom_07              :string(255)
#  custom_08              :string(255)
#  custom_09              :string(255)
#  custom_10              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class PlayerOrganizationExt < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :player_organization

end
