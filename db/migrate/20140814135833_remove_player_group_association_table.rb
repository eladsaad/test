class RemovePlayerGroupAssociationTable < ActiveRecord::Migration
  def change

	if ActiveRecord::Base.connection.table_exists? 'player_group_associations'
		error = false
	  	Player.all.each do |player|
	  		current_group_id = ActiveRecord::Base.connection.execute("select player_group_id from player_group_associations where player_id = #{player.id};");
	  		current_group_id = current_group_id.first['player_group_id']
	  		player.player_group_id = current_group_id
	  		puts player
	  		player.save!
	  		if player.player_group_id.blank?
	  			error = true
  			end
		end
		drop_table :player_group_associations unless error
	end

  end
end
