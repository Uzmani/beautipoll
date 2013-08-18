def check_user_login
  unless @user
    session[:error] = []
    session[:error] << "Please log in first!"
  end
end