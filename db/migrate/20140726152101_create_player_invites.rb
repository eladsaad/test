class CreatePlayerInvites < ActiveRecord::Migration
  def change
    create_table :player_invites do |t|
      t.integer :inviting_player_id
      t.text :email
      t.string :friend_type
      t.text :message

      t.timestamps
    end

    add_index :player_invites, :inviting_player_id
  end
end
