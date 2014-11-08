class QuizController < ApplicationController

  layout 'quiz'
  
  def index
  end

  def show
  	start params
  end
  
  def start
  	# check to see is parameter buttons were clicked
  		if params[:easy]
  			total = 5
  		elsif params[:medium]
  			total = 10
  		else
  			total = 15
  		end

	 # total = params[:number].to_i
	 all = Question.find(:all).map {|x| x.id}

	 session[:questions] = all.sort_by{rand}[0..(total-1)]
	 session[:total]   = total
	 session[:current] = 0
	 session[:correct] = 0
	 session[:questions_array] = Array.new

	 redirect_to :action => "question"
  end

  def question
	 @current = session[:current]
	 @total   = session[:total]
	 
	 if @current >= @total
		redirect_to :action => "end"
		return
	 end
	 
	 @question = Question.find(session[:questions][@current])
	 @choices = @question.choices.sort_by{rand}
	 
	 session[:question] = @question
	 session[:choices] = @choices
	 puts "Question is #{@question.id}: #{@question.text}"
  end

  def answer
  	puts "Answer is for #{session[:question].id}: #{session[:question].text}"
  	puts session[:questions_array]
  	puts "key is: #{params["keep"].keys[0]}"


  	 if session[:questions_array].include? params[:question].to_i
  	 	redirect_to :action => "ended_early"
		return
  	 end

	 @current = session[:current]
	 @total   = session[:total]
	 choiceid = params["keep"].keys.first
	 @question = session[:question]
	 @choices  = session[:choices]
	 session[:questions_array] << @question.id

	 puts 'here:'
	 puts @current
	 puts @total
	 puts choiceid
	 puts ' question:'
	 puts @question.id
	 # puts @choices

	 @choice = choiceid ? Choice.find(choiceid) : nil
	 if @choice and @choice.correct
		@correct = true
		session[:correct] += 1
	 else
		@correct = false
	 end
	 
	 session[:current] += 1
  end

  def end
	 @correct = session[:correct]
	 @total   = session[:total]
	 
	 @score = @correct * 100 / @total
  end

  def ended_early
  	 @correct = session[:correct]
	 @total   = session[:total]
  end
end
