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
  end

  def answer
	 @current = session[:current]
	 @total   = session[:total]
	 
	 choiceid = params["edit"].keys.first

	 @question = session[:question]
	 @choices  = session[:choices]

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
end
