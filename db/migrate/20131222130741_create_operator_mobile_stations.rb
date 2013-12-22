class CreateOperatorMobileStations < ActiveRecord::Migration
  def change
    create_table :operator_mobile_stations do |t|
      t.integer :operator_id
      t.string :code

      t.timestamps
    end

    add_index :operator_mobile_stations, :operator_id
  end
end
