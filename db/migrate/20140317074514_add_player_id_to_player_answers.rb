class AddPlayerIdToPlayerAnswers < ActiveRecord::Migration
  def change
    add_column :player_answers, :player_id, :integer
    add_index :player_answers, :player_id
  end
end
