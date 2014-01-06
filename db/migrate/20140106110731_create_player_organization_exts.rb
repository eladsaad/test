class CreatePlayerOrganizationExts < ActiveRecord::Migration
  def change
    create_table :player_organization_exts do |t|
      t.integer :player_organization_id
      t.string :custom_01
      t.string :custom_02
      t.string :custom_03
      t.string :custom_04
      t.string :custom_05
      t.string :custom_06
      t.string :custom_07
      t.string :custom_08
      t.string :custom_09
      t.string :custom_10

      t.timestamps
    end

    add_index :player_organization_exts, :player_organization_id , unique: true
  end
end
