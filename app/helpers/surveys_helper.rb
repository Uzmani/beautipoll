helpers do   
  def question_replies(survey, choice)
    unless survey.completed_surveys.empty?
      survey.completed_surveys.where(:user_id =>
      current_user.id).first.replies.select {|reply| reply.choice_id ==
      choice.id}
    else
      Array.new
    end
  end 
end
