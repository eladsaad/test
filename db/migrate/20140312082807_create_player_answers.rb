class CreatePlayerAnswers < ActiveRecord::Migration
  def change
    create_table :player_answers do |t|
      t.integer :player_group_id
      t.integer :survey_id
      t.integer :question_id
      t.integer :answer_number

      t.timestamps
    end
  end
end
