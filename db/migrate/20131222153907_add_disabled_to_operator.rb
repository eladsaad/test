class AddDisabledToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :disabled, :boolean, default: false
  end
end
