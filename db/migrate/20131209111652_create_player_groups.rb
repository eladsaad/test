class CreatePlayerGroups < ActiveRecord::Migration
  def change
    create_table :player_groups do |t|
      t.integer :operator_id
      t.string :reg_code
      t.date :program_start_date
      t.string :name
      t.text :description
      t.integer :player_organization_id

      t.timestamps
    end

    add_index :player_groups, :operator_id
    add_index :player_groups, :reg_code
    add_index :player_groups, :player_organization_id
  end
end
