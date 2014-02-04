class CreateOnlineProgramNotifications < ActiveRecord::Migration
  def change
    create_table :online_program_notifications do |t|
      t.integer :online_program_id
      t.integer :notification_id
      t.integer :start_after_days
      t.time :start_time

      t.timestamps
    end

    add_index :online_program_notifications, :online_program_id
    add_index :online_program_notifications, :notification_id
  end
end
