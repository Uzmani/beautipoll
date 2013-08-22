post '/surveys/new' do
  @survey = Survey.create({
    title: params[:title],
    visibility: (params[:make_private] ? 1 : 0),
    url: SecureRandom.hex(4),
    user: (User.find(session[:user_id])),
    image: params[:image]
    })
    @survey.save
  #@questions = Question.where(survey_id: @survey.id)
  session[:survey_id] = @survey.id
  @survey.id.to_json
end

get '/surveys/new_q' do
  erb :'surveys/question'
end



get '/surveys/edit/:id' do
  @user = User.find(session[:user_id])  
  @survey = Survey.find_by_id(params[:id])  
  session[:survey_id] = @survey.id if @survey
  @questions = Question.where(survey_id: @survey.id) if @survey
  # check_correct_user
  # @correct_user ? (erb :'surveys/new_survey') : (redirect '/')
  erb :'surveys/new_survey'
end

post '/surveys/delete_survey' do
  Survey.find(params[:survey_id]).destroy
end

post '/surveys/new_q' do
  @survey = Survey.find(session[:survey_id])  
  @question = Question.create({
    survey: @survey,
    content: params[:content],
    format: params[:q_type]
    })
  choices = params[:choice].split(".y.y.")
  choices.each do |choice|
    Choice.create({
      question: @question,
      content: choice
      }) unless choice == ""
  end
  @questions = Question.where(survey_id: @survey.id)
  session[:survey_id] = @survey.id
  @survey.id.to_json
end

post '/surveys/get_q' do
  @question = Question.find(params[:question_num])
  erb :'surveys/get_q', :layout => false
end

post '/surveys/edit_q' do
  @survey = Survey.find(session[:survey_id])  
  @question = Question.find(params[:question_num])
  @question.content = params[:content]
  @question.format = params[:q_type]
  @question.save
  Choice.destroy_all("question_id" => params[:question_num])
  choices = params[:choice].split(".y.y.")
  choices.each do |choice|
    Choice.create({
      question: @question,
      content: choice
      }) unless choice == ""
  end
  @questions = Question.where(survey_id: @survey.id)
  session[:survey_id] = @survey.id
  @survey.id.to_json
end

post '/surveys/delete_q' do
  @survey = Survey.find(session[:survey_id])  
  Question.find(params[:question_num]).destroy  
  @questions = Question.where(survey_id: @survey.id)
  @survey.id.to_json
end

get '/surveys/complete' do
  @survey = Survey.find(session[:survey_id])  
  session[:survey_id] = nil
  erb :'surveys/thanks'
end

get '/take_survey' do
  #@user = User.find(session[:user_id])  
  @survey = Survey.where(visibility: 0).sample
  @current_survey = CompletedSurvey.where(survey_id: @survey.id, user_id: current_user.id).first  
  @replies = (@current_survey ? (Reply.where(completed_survey_id: @current_survey.id)) : [])
  session[:taking_survey] = @survey.id if @survey
  erb :"surveys/take_survey"
end

get '/take_survey/:url' do 
  @survey = Survey.find_by_url(params[:url])  
  @current_survey = CompletedSurvey.where(survey_id: @survey.id, user_id: current_user.id).first  
  if @current_survey
    @replies = Reply.where(completed_survey_id: @current_survey.id)
  else
    @replies = []
  end
  erb :"surveys/take_survey"
end

post '/answer_survey' do
  @survey = Survey.find(params[:survey_id])
  @user = User.find(session[:user_id])  
  existing_survey = CompletedSurvey.where({user_id: @user.id, survey_id: @survey.id}).first  
  if existing_survey
    @current_survey = existing_survey
  else
    @current_survey = CompletedSurvey.create({user: @user, survey: @survey})
  end
  Reply.destroy_all("completed_survey_id" => @current_survey.id)
  params.each do |question_id, choice|
    if question_id.include?("choice")
      current_choice = Choice.find(choice.join.to_i)  
      Reply.create({choice: current_choice, completed_survey: @current_survey})
    end
  end
  session[:taking_survey] = nil
  redirect '/'
end

get '/survey/:id' do
  @user = User.find(session[:user_id])  
  @survey = Survey.find_by_id(params[:id])
  @questions = Question.where(survey_id: @survey.id)
  erb :'profile/results'
end


# ---------------------------------------------------!!!!!!!
# This route was made for the presentation only.

# get '/create' do
#   @user = User.find(session[:user_id])  
#   @survey = Survey.find_by_url("ab40b151")  
#   @survey.user = @user if @survey
#   @survey.save if @survey
#   redirect '/'
# end
# ---------------------------------------------------

