class CreatePlayerOrganizations < ActiveRecord::Migration
  def change
    create_table :player_organizations do |t|
      t.string :org_type
      t.string :name
      t.text :address
      t.string :contact_name
      t.string :contact_position
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
