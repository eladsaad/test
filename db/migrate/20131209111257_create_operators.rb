class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :name
      t.string :email
      t.string :country
      t.string :reg_code_prefix

      t.timestamps
    end
  end
end
