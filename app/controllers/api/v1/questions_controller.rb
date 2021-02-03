# rails g controller api/v1/questions --no-assets --no-helper --skip-template-engine
# module Api
#     module V1
#         class QuestionController < ApplicationController
#         end
#     end
# end
# 👆🏻 is like this 👇🏻
class Api::V1::QuestionsController < ApplicationController
  def index
    # curl http://localhost:3000/api/v1/questions #👈🏻 on terminal
    # or
    # http://localhost:3000/api/v1/questions # 👈🏻 on browser
    questions = Question.order created_at: :desc
    render json: questions, each_serializer: QuestionCollectionSerializer
  end

  def show
    question = Question.find params[:id]
    render json: question
  end
end
