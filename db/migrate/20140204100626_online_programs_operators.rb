class OnlineProgramsOperators < ActiveRecord::Migration
  def change
  	create_table :online_programs_operators do |t|
      t.integer :online_program_id
      t.integer :operator_id

      t.timestamps
    end

    add_index :online_programs_operators, :operator_id
    add_index :online_programs_operators, [:operator_id, :online_program_id], unique: true, name: 'online_program_operator_index'
  end
end
