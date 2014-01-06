class AddGenderToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :gender, :string
  end
end
