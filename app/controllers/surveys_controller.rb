post '/surveys/new' do
  @survey = Survey.create({
    title: params[:title],
    visibility: (params[:make_private] ? 1 : 0),
    url: SecureRandom.hex(4),
    user: (User.find(session[:user_id]) rescue nil)
    })
  if params[:image]
    image_url = "/uploads/#{@survey.id}icon." + params[:image][:filename].split(".").last
    File.open("public#{image_url}", "w") do |f|
      f.write(params[:image][:tempfile].read)
    end
    @survey.image_url = image_url
    @survey.save
  end
  @questions = Question.where(survey_id: @survey.id)
  session[:survey_id] = @survey.id
  @survey.id.to_json
end

get '/surveys/new_q' do
  erb :'surveys/question'
end

get '/surveys/edit/:id' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.find_by_id(params[:id]) rescue nil
  session[:survey_id] = @survey.id if @survey
  @questions = Question.where(survey_id: @survey.id) if @survey
  check_correct_user
  @correct_user ? (erb :'surveys/new_survey') : (redirect '/')
end

post '/surveys/new_q' do
  @survey = Survey.find(session[:survey_id]) rescue nil
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
  @survey = Survey.find(session[:survey_id]) rescue nil
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
  @survey = Survey.find(session[:survey_id]) rescue nil
  Question.find(params[:question_num]).destroy rescue nil
  @questions = Question.where(survey_id: @survey.id)
  @survey.id.to_json
end

get '/surveys/complete' do
  @survey = Survey.find(session[:survey_id]) rescue nil
  session[:survey_id] = nil
  erb :'surveys/thanks'
end

get '/take_survey' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.where(visibility: 0).sample
  @current_survey = CompletedSurvey.where(survey_id: @survey.id, user_id: @user.id).first rescue nil
  @replies = (@current_survey ? (Reply.where(completed_survey_id: @current_survey.id)) : [])
  session[:taking_survey] = @survey.id if @survey
  erb :"surveys/take_survey"
end

get '/take_survey/:url' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.find_by_url(params[:url]) rescue nil
  @current_survey = CompletedSurvey.where(survey_id: @survey.id, user_id: @user.id).first rescue nil
  if @current_survey
    @replies = Reply.where(completed_survey_id: @current_survey.id)
  else
    @replies = []
  end
  session[:taking_survey] = @survey.id if @survey
  check_user_login
  check_survey_exists
  @user ? (@survey ? (erb :"surveys/take_survey") : (redirect '/')) : (redirect '/')
end

post '/answer_survey' do
  @survey = Survey.find(params[:survey_id])
  @user = User.find(session[:user_id]) rescue nil
  existing_survey = CompletedSurvey.where({user_id: @user.id, survey_id: @survey.id}).first rescue nil
  if existing_survey
    @current_survey = existing_survey
  else
    @current_survey = CompletedSurvey.create({user: @user, survey: @survey})
  end
  Reply.destroy_all("completed_survey_id" => @current_survey.id)
  params.each do |question_id, choice|
    if question_id.include?("choice")
      current_choice = Choice.find(choice.join.to_i) rescue nil
      Reply.create({choice: current_choice, completed_survey: @current_survey})
    end
  end
  session[:taking_survey] = nil
  redirect '/'
end

get '/survey/:id' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.find_by_id(params[:id])
  @questions = Question.where(survey_id: @survey.id)
  erb :'profile/results'
end