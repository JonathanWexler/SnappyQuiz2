class Question < ActiveRecord::Base
  # belongs_to :quiz
  has_many :choices
  acts_as_list
  
  def answer
	 uncorrect
	 choices.select {|c| c.correct}[0]
  end	
  
  def uncorrect
	 choices.each {|c| c.correct = false}
  end
  
  def answer= choice
	 if !answer.nil?
		answer.correct = false
	 end
	 
	 if choices.include? choice
		choice.correct = true
	 else
		choices << choice
		choice.correct = true
	 end
  end
end


# class Question < ActiveRecord::Base
# end


# ~~~~~ Code Sharing Area ~~~~~
#  Use this box to share and edit code

# class Quiz < ActiveRecord::Base
#   has_many :questions
# end

# class Question < ActiveRecord::Base
#   has_many :answers
#   belongs_to :quiz
  
#   #has a proptery numer:integer -> to know where it will come in the series of questions

#   def answer_it user
#     user.user_quiz
#   end
# end

# class Answer < ActiveRecord::Base
#   belongs_to :question
# end


# class User < ActiveRecord::Base
#   has_many :user_answers
# end

# class UserAnswer < ActiveRecord::Base
#   belongs_to :answer
#   belongs_to :user
#   belongs_to :quiz
# end


# class UserQuiz < ActiveRecord::Base
#   belongs_to :user
#   belongs_to :quiz
  
#   has_mant :user_answers
# end




# ===========

# ~~~~~ Code Sharing Area ~~~~~
#  Use this box to share and edit code


# #ok :)

# #you have a class


# class User < ActiveRecord::Base
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :trackable, :validatable
# end

# class Quiz < ActiveRecord::Base
#   has_many :questions
# end

# class Question < ActiveRecord::Base
#   has_many :answers
#   belongs_to :quiz
  
#   #has a proptery numer:integer -> to know where it will come in the series of questions
# end

# class Answer < ActiveRecord::Base
#   belongs_to :question
# end


# class User < ActiveRecord::Base
#   has_many :user_answers
# end

# class UserAnswer < ActiveRecord::Base
#   belongs_to :answer
#   belongs_to :user
#   belongs_to :question
#   belongs_to :user_quiz
# end


# class UserQuiz < ActiveRecord::Base
#   belongs_to :user
#   belongs_to :quiz
  
#   has_many :user_answers
# end