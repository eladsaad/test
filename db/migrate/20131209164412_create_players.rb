class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.date :birth_date

      t.timestamps
    end

    add_index :players, :username, unique: true
    add_index :players, :email, unique: true
  end
end
