class AddLastRegCodeIdToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :last_reg_code_id, :integer
  end
end
