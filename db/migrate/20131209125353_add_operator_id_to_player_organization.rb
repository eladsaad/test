class AddOperatorIdToPlayerOrganization < ActiveRecord::Migration
  def change
    add_column :player_organizations, :operator_id, :integer
    add_index :player_organizations, :operator_id
  end  
end
