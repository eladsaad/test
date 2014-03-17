json.array!(@player_answers) do |player_answer|
  json.extract! player_answer, :id, :player_group_id, :survey_id, :question_id, :answer_number
  json.url player_answer_url(player_answer, format: :json)
end
