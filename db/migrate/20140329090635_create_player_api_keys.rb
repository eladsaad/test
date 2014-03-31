class CreatePlayerApiKeys < ActiveRecord::Migration
  def change
    create_table :player_api_keys do |t|
      t.string :access_token
      t.datetime :expires_at
      t.integer :player_id
      t.boolean :active

      t.timestamps
    end

    add_index :player_api_keys, :player_id, unique: false
    add_index :player_api_keys, :access_token, unique: true
  end
end
