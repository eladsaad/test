class CreatePlayerSessions < ActiveRecord::Migration
  def change
    create_table :player_sessions do |t|
      t.integer :player_id
      t.datetime :sign_in_at
      t.datetime :sign_out_at
      t.string :ip_address
      t.string :session_id
    end

    add_index :player_sessions, :player_id
  end
end
