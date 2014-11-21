class AddMaxPlayersToGroup < ActiveRecord::Migration
  def change
  	add_column :player_groups, :max_players, :integer
  end
end
