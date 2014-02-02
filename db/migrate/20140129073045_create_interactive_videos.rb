class CreateInteractiveVideos < ActiveRecord::Migration
  def change
    create_table :interactive_videos do |t|
      t.string :name
      t.text :content
      t.integer :language_code_id
      t.text :description

      t.timestamps
    end
  end
end
