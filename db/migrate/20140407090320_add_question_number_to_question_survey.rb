class AddQuestionNumberToQuestionSurvey < ActiveRecord::Migration
  def change
    add_column :questions_surveys, :question_number, :integer
  end
end
