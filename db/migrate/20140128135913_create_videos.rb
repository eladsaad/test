class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :thumbnail_url
      t.string :name
      t.integer :language_code_id
      t.text :description

      t.timestamps
    end
  end
end
