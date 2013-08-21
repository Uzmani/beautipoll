get '/' do
  @users = User.all
  @email = User.find(session[:user_id]).email rescue nil
  @user_id = session[:user_id]
  @user = User.find(@user_id) rescue nil
  @error = session[:error]
  session[:error] = nil
  @surveys_taken = CompletedSurvey.where(user_id: @user_id)
  # @taking_survey = session[:taking_survey]
  # url = Survey.find(@taking_survey).url if @taking_survey
  # session[:taking_survey] = nil
  # (@taking_survey ? (redirect "/take_survey/#{url}") : 
  @user ? (erb :"profile/profile") : (erb :index)
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
  redirect '/'
end
#--------------image upload tester-------------


  get '/image_display' do
    @uploads = Upload.all
    erb :test
  end
 
  post '/image_uploader' do
    upload = Upload.new
    upload.file = params[:image]
    upload.save
    redirect to('/image_display')
  end

