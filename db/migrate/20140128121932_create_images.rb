class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :thumbnail_url
      t.string :name
      t.text :description
      t.string :format

      t.timestamps
    end
  end
end
