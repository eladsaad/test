class AddSignUpSurveyToOnlineProgram < ActiveRecord::Migration
  def change
    add_column :online_programs, :sign_up_survey_id, :integer
  end
end
