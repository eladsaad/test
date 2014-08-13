class ChangeSurveyIdToExternalSurveyIdInPlayerAnswer < ActiveRecord::Migration
  def change
  	rename_column :player_answers, :survey_id, :external_survey_id
  	change_column :player_answers, :external_survey_id, :string
  	add_index :player_answers, [:player_id, :external_survey_id]
  end
end
