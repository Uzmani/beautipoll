def validate_and_create_user
  validate_user
  create_user
end

def validate_user
  session[:error] = []
  if params[:user]["password"].length < 6
    session[:error] << "Please ensure your password is at least 6 characters in length."
  end
  params[:user]["password_hash"] = BCrypt::Password.create(params[:user]["password"])
  params[:user].delete("password")
  @user = User.new(params[:user])
end

def create_user
  if @user.valid?
    session[:error] = nil
    @user.save
    session[:user_id] = @user.id
  else
    session[:error] << "You've already created an account with this email address.  Please login!"
  end
end