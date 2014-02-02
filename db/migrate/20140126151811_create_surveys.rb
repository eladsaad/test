class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.integer :language_code_id
      t.text :question_ids

      t.timestamps
    end
  end
end
