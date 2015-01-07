# == Schema Information
#
# Table name: players
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  birth_date             :date
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
#  gender                 :string(255)
#  profile_picture        :string(255)
#  age                    :integer
#  tos_accepted           :boolean          default(FALSE)
#  player_group_id        :integer
#

class Operation::Player < Player

	def self.additional_sort_columns
		['player_groups.name']
	end

end
