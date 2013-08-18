post '/surveys/new' do
  p params
  if params[:image]
    File.open('public/uploads/' + params[:image][:filename], "w") do |f|
      f.write(params[:image][:tempfile].read)
    end
    image_url = "/uploads/#{params[:image][:filename]}"
  else
    image_url = nil
  end
  @survey = Survey.create({
    title: params[:title],
    image_url: image_url,
    visibility: (params[:make_private] ? 1 : 0),
    url: SecureRandom.hex(4),
    user: (User.find(session[:user_id]) rescue nil)
    })
  @questions = Question.where(survey_id: @survey.id)
  session[:survey_id] = @survey.id
  erb :'surveys/new_survey', :layout => false
end

get '/surveys/new_q' do
  erb :'surveys/question'
end

get '/surveys/escape' do
  @survey = Survey.find(session[:survey_id]) rescue nil
  @questions = Question.where(survey_id: @survey.id)
  erb :'surveys/new_survey', :layout => false
end

post '/surveys/new_q' do
  @survey = Survey.find(session[:survey_id]) rescue nil
  @question = Question.create({
    survey: @survey,
    content: params[:content]
    })
  choices = params[:choice].split(".y.y.")
  choices.each do |choice|
    Choice.create({
      question: @question,
      content: choice
      }) unless choice == ""
  end
  @questions = Question.where(survey_id: @survey.id)
  erb :'surveys/new_survey', :layout => false
end

post '/surveys/complete' do
  #give user url link
  session[:survey_id] = nil
  erb :'surveys/thanks'
end

get '/take_survey' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.all.sample
  erb :"surveys/take_survey"
end

get '/take_survey/:id' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.find(params[:id])
  @current_survey = CompletedSurvey.where(survey: @survey, user: @user).first
  erb :"surveys/take_survey"
end

post '/answer_survey' do
  @survey = Survey.find(params[:survey_id])
  @user = User.find(session[:user_id]) rescue nil
  @completed_survey = CompletedSurvey.create({user: @user, survey: @survey})
  params.each do |question_id, choice|
    if question_id.include?("choice")
      current_choice = Choice.find(choice.join.to_i) rescue nil
      Reply.create({choice: current_choice, completed_survey: @completed_survey})
    end
  end
  redirect '/'
end

get '/survey/:id' do
  @user = User.find(session[:user_id]) rescue nil
  @survey = Survey.find_by_id(params[:id])
  @questions = Question.where(survey_id: @survey.id)
  erb :'profile/results'
end