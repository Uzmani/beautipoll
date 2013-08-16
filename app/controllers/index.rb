get '/' do
  @users = User.all
  @email = User.find(session[:user_id]).email rescue nil
  @error = session[:error]
  session[:error] = nil
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  @email = User.find(session[:user_id]).email rescue nil
  session[:error] = nil
  erb :sign_in
end

post '/sessions' do
  confirm_login
  redirect '/'
end

delete '/sessions/:id' do
  session.clear
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  validate_and_create_user
  @user_id = session[:user_id]
  @surveys_taken = CompletedSurvey.where(user_id: @user_id)
  @user_id ? (erb :"profile/profile") : (redirect '/')
end
