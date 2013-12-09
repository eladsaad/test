class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :name
      t.string :email
      t.string :country
      t.string :reg_code_prefix, limit: 2

      t.timestamps
    end

    add_index :operators, :email, unique: true
  end
end
