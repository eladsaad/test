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
  end
end
