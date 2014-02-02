json.array!(@admin_questions) do |admin_question|
  json.extract! admin_question, :id, :name, :language_code_id, :question, :answers, :correct_answer
  json.url admin_question_url(admin_question, format: :json)
end
