get '/questions' do

  @questions = Question.all
  @questions.each do |question|
    question.get_total_votes
  end

  erb :'questions/index'
end

get '/questions/new' do
  erb :'questions/new'
end

post '/questions' do
    binding.pry
    @user = current_user
    @question = Question.new(params[:question]) #create new question
    @question.user = @user
    if @question.save
      redirect '/questions'
    else
      erb :'questions/new' # show new questions view again(potentially displaying errors)
    end
  end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @question.answers.each do |answer|
    answer.get_total_votes
  end

  erb :'questions/show'
end
