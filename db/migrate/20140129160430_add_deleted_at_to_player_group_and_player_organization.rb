class AddDeletedAtToPlayerGroupAndPlayerOrganization < ActiveRecord::Migration
  def change
  	add_column :player_groups, :deleted_at, :datetime
  	add_column :player_organizations, :deleted_at, :datetime
  end
end
