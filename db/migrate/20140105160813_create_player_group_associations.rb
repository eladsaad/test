class CreatePlayerGroupAssociations < ActiveRecord::Migration
  def change
    create_table :player_group_associations do |t|
      t.integer :player_id
      t.integer :player_group_id

      t.timestamps
    end

    add_index :player_group_associations, :player_id
    add_index :player_group_associations, :player_group_id
    add_index :player_group_associations, [:player_group_id, :player_id], unique: true, name: 'index_player_group_assoc_on_player_group_id_and_player_id'
  end
end
