class AddDeviseToOperators < ActiveRecord::Migration
  def self.up
    change_table(:operators) do |t|
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

    add_index :operators, :reset_password_token, :unique => true
    add_index :operators, :confirmation_token,   :unique => true
  end

  def self.down
    remove_index :operators, :reset_password_token
    remove_index :operators, :confirmation_token
    remove_column :operators, :encrypted_password
    remove_column :operators, :reset_password_token
    remove_column :operators, :reset_password_sent_at
    remove_column :operators, :remember_created_at
    remove_column :operators, :confirmation_token
    remove_column :operators, :confirmed_at
    remove_column :operators, :confirmation_sent_at
    remove_column :operators, :unconfirmed_email
  end
end
