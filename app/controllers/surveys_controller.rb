get '/surveys/new' do
  erb :'surveys/new'
end

get '/surveys/:id' do
  @survey = Survey.find_by_id(params[:id])
  @answers = params[:answer]
  @questions = params[:question]
  erb :'surveys/show'
end

post '/surveys' do
  @survey = Survey.new(title: params[:title])
  if @survey.save
    redirect "surveys/#{@survey.id}"
  else
    erb :'surveys/new'
  end
end