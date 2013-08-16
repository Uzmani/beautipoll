def confirm_login
  session[:error] = []
  if User.where(email: params[:email]).count > 0
    if User.authenticate(params[:email], params[:password])
      session[:user_id] = User.where(email: params[:email]).first.id
    else
      session[:error] << "Incorrect password.  Please try again!"
    end
  else
    session[:error] << "Invalid email!  Please try again."
  end
end