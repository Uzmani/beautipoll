
# get '/surveys/new' do
#   erb :'surveys/new'
# end

# post '/surveys/new' do
#   @survey = Survey.new(params)
#   if @survey.save
#     {title: params[:title]}.to_json
#   else
#     erb :'surveys/new'  
#   end
#   erb :'questions/new'
# end

# get '/surveys/new' do
#   erb :"surveys/new"
# end

# post '/surveys' do
#   @survey = Survey.new(params)
#   if @survey.save
#     {title: params[:title]}.to_json
#   else
#     erb :'surveys/new'  
#   end
#   erb :'questions/new'
# end

# -----------------------------------

get '/surveys/new' do
  erb :'surveys/title'
end

post '/surveys/new' do
  Survey.new##
  @title = 
  erb :'surveys/new_survey'
end

get '/surveys/new_q' do
  erb :'surveys/question'
end

post '/surveys/new_q' do
  @question = 
  @answers = 
  erb :'surveys/new_survey'
end

post '/survey/complete' do
  @alter state of survey
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