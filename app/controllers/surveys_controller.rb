get '/surveys/new' do
  ttitle = params[:survey_title]

  {title: title}.to_json
  erb :'surveys/new'
end

get '/surveys/:id' do
  @survey = Survey.find_by_id(params[:id])
  @answers = params[:answer]
  @questions = params[:question]
  erb :'surveys/show'
end

#or
  # @title = Survey.find_by_id(@survey)
  # erb :'profile/result'

post '/surveys' do
  @survey = Survey.new(title: params[:title])
  if @survey.save
    {title: params[:title]}.to_json
  else
    erb :'surveys/new'
  end
end