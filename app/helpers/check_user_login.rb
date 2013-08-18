def check_survey_exists
  if @user
    unless @survey
      session[:error] = []
      session[:error] << "Sorry, we can't find this survey!"
    end
  else
    unless @survey
      session[:error] << "Sorry, we can't find this survey!"
    end
  end
end