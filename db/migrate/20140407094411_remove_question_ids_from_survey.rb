class RemoveQuestionIdsFromSurvey < ActiveRecord::Migration
  def change
  	remove_column :surveys, :question_ids
  end
end
