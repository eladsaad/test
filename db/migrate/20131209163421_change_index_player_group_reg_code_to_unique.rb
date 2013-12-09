class ChangeIndexPlayerGroupRegCodeToUnique < ActiveRecord::Migration
  def change
  	remove_index  :player_groups, :reg_code
  	add_index :player_groups, :reg_code, unique: true
  end
end
