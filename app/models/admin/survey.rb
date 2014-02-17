class Admin::Survey < Survey

  # == METHODS ==

  def questions_to_add
    Admin::Question.where.not(id: self.question_ids).where(language_code_id: self.language_code_id)
  end

end