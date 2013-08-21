get '/' do
  # @users = User.all
  # @email = User.find(session[:user_id]).email 
  # @user_id = session[:user_id]
  # @user = User.find(@user_id) 
  # @error = session[:error]
  # session[:error] = nil
  @surveys_taken = CompletedSurvey.where(user_id: @user_id)
  # @taking_survey = session[:taking_survey]
  # url = Survey.find(@taking_survey).url if @taking_survey
  # session[:taking_survey] = nil
  # (@taking_survey ? (redirect "/take_survey/#{url}") : 
  @user ? (erb :"profile/profile") : (erb :index)
end

#----------- SESSIONS -----------

get '/sessions/new' do
  @email = User.find(session[:user_id]).email 
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
  
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :sign_up
  end
end
