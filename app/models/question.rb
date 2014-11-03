class Question < ActiveRecord::Base
  belongs_to :quiz
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