class AddDeviseToSystemAdmins < ActiveRecord::Migration
  def self.up
    change_table(:system_admins) do |t|
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

    add_index :system_admins, :reset_password_token, :unique => true
    add_index :system_admins, :confirmation_token,   :unique => true
  end

  def self.down
    remove_index :system_admins, :reset_password_token
    remove_index :system_admins, :confirmation_token
    remove_column :system_admins, :encrypted_password
    remove_column :system_admins, :reset_password_token
    remove_column :system_admins, :reset_password_sent_at
    remove_column :system_admins, :remember_created_at
    remove_column :system_admins, :confirmation_token
    remove_column :system_admins, :confirmed_at
    remove_column :system_admins, :confirmation_sent_at
    remove_column :system_admins, :unconfirmed_email
  end
end
