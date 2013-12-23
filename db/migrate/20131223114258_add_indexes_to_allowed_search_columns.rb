class AddIndexesToAllowedSearchColumns < ActiveRecord::Migration
  def change
  	add_index :operator_mobile_stations, :code
  	
  	add_index :operators, :name
  	
  	add_index :player_groups, :name
  	add_index :player_groups, :description

  	add_index :player_organizations, :name
  	add_index :player_organizations, :contact_email

  	add_index :system_admins, :first_name
  	add_index :system_admins, :last_name
  end
end
