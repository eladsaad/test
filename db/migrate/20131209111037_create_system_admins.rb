class CreateSystemAdmins < ActiveRecord::Migration
  def change
    create_table :system_admins do |t|
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :system_admins, :email, unique: true
  end
end
