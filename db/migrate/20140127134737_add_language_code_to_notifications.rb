class AddLanguageCodeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :language_code, :integer
  end
end
