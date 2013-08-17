get '/surveys/new' do
  erb :'surveys/new'
end

get '/surveys/:id' do
  @survey = Survey.find_by_id(params[:id])
  @answers = params[:answer]
  @questions = params[:question]
  erb :'surveys/show'
end

post '/surveys/new' do
  @survey = Survey.new(title: params[:title])
  if @survey.save
    {title: params[:title]}.to_json
  else
    erb :'surveys/new'  
  end
  erb :'questions/new'
end