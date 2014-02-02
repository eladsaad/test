class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :language_code_id
      t.text :question
      t.text :answers
      t.integer :correct_answer

      t.timestamps
    end
  end
end
