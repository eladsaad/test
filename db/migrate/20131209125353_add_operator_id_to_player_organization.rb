class AddOperatorIdToPlayerOrganization < ActiveRecord::Migration
  def change
    add_column :player_organizations, :operator_id, :integer
  end
end
