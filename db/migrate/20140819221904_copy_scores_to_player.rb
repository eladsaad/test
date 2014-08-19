class CopyScoresToPlayer < ActiveRecord::Migration
  
  def up

  	raise "scores table does not exist!" unless ActiveRecord::Base.connection.table_exists? 'scores'

	error = false
	scores_tmp = {}

	add_column :players, :score, :integer, default: 0

	Player.reset_column_information

  	Player.all.each do |player|
  		tmp_score = ActiveRecord::Base.connection.execute("select score from scores where player_id = #{player.id};");
      current_score = tmp_score.first['score'] unless tmp_score.first.nil?
      current_score ||= 0
  		scores_tmp[player.id] = current_score
  		player.score = current_score
  		player.save!
  		player.reload
  		puts "Player id [#{player.id}] score [#{player.score}]"
	end

	# verification
	Player.all.each do |player|
  		error = error || (player.score.to_i != scores_tmp[player.id].to_i)
	end

	raise "error occured" if error
	drop_table :scores unless error

  end

  def down
  	remove_column :players, :score, :integer
  end

end
