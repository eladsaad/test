class CreateQuestionSurveys < ActiveRecord::Migration
  def change
    create_table :questions_surveys do |t|
      t.integer :question_id
      t.integer :survey_id

      t.timestamps
    end
  end
end
