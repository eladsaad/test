class CreatePlayerAuthentications < ActiveRecord::Migration
  def change
    create_table :player_authentications do |t|
      t.integer :player_id
      t.string :provider
      t.string :uid
      t.string :token
      t.string :token_secret

      t.timestamps
    end

    add_index :player_authentications, :player_id, unique: true
  end
end
