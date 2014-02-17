class CreatePlayerProgresses < ActiveRecord::Migration
  def change
    create_table :player_progresses do |t|
      t.integer :player_id
      t.integer :player_group_id
      t.integer :last_interactive_video_index, default: 0

      t.timestamps
    end

    add_index :player_progresses, [:player_id, :player_group_id]
  end
end
