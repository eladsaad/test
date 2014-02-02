class CreateOnlinePrograms < ActiveRecord::Migration
  def change
    create_table :online_programs do |t|
      t.string :name
      t.string :codename
      t.integer :language_code_id
      t.text :description
      t.integer :background_image_id
      t.integer :promo_video_id

      t.timestamps
    end

    add_index :online_programs, :language_code_id
    add_index :online_programs, :codename
    add_index :online_programs, :name
  end
end
