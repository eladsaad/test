class AddDeviseToPlayers < ActiveRecord::Migration
  def self.up
    change_table(:players) do |t|
      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
    end

    add_index :players, :reset_password_token, :unique => true
    add_index :players, :confirmation_token,   :unique => true
  end

  def self.down
    remove_index :players, :reset_password_token
    remove_index :players, :confirmation_token
    remove_column :players, :encrypted_password
    remove_column :players, :reset_password_token
    remove_column :players, :reset_password_sent_at
    remove_column :players, :remember_created_at
    remove_column :players, :confirmation_token
    remove_column :players, :confirmed_at
    remove_column :players, :confirmation_sent_at
    remove_column :players, :unconfirmed_email
  end
end
