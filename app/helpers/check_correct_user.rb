def check_correct_user
  @correct_user = (@user ? (@user.id == @survey.user_id ? true : false) : false)
  unless @correct_user
    session[:error] = []
    session[:error] << "I'm sorry, you don't have editing privileges for that survey."
  end
end