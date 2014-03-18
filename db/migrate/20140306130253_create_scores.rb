class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :player_group_id
      t.integer :player_id
      t.integer :score

      t.timestamps
    end
  end
end