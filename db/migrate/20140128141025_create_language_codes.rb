class CreateLanguageCodes < ActiveRecord::Migration
  def change
    create_table :language_codes do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
