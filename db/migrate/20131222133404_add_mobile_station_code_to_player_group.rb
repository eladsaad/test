class AddMobileStationCodeToPlayerGroup < ActiveRecord::Migration
  def change
    add_column :player_groups, :mobile_station_code, :string
  end
end
