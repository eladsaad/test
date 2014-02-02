class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :name
      t.integer :language_code_id
      t.text :description
      t.text :title
      t.text :facebook_content
      t.text :email_content

      t.timestamps
    end
  end
end
