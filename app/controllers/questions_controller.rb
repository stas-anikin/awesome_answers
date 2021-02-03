class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # 1. Create Index method
  # 2. Create view for it in views/questions index.html.erb
  # 3. Wiring every thing together with a route
  def index
    # puts params[:tag]
    if params[:tag]
      @tag = Tag.find_or_initialize_by(name: params[:tag])
      @questions = @tag.questions.all_with_answer_counts.order(updated_at: :desc)
    else
      # @questions=Question.all.order(created_at: :desc)
      @questions = Question.all.all_with_answer_counts.order(updated_at: :desc)
    end
    respond_to do |format|
      format.html { render }
      format.json { render json: @questions }
    end
  end

  def liked
    # @questions= current_user.liked_questions.order(created_at: :desc)
    @questions = current_user.liked_questions.all_with_answer_counts.order(created_at: :desc)
  end

  # 1. Create show method
  # 2. Create view for it in views/questions show.html.erb
  # 3. Wiring every thing together with a route

  def show
    # puts params[:id]
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new
    @like = @question.likes.find_by(user: current_user)
  end

  # Create destroy method
  # creating a link for destroy
  # We need a route
  # divert user back to an index page

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  #  CREATE ACTION
  # 1. Initialize a form
  # 1a Route to take to the form
  # 1b Form itself
  # 2. Storing the values
  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      flash[:notice] = "Question created successfully."
      redirect_to question_path(@question.id)
    else
      render :new
    end
  end

  # EDITING A QUESTION
  # Need id
  # form filled with question detail
  # submit Question should be updated
  # directed to that question
  def edit
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question.id), notice: "Question edited successfully."
    else
      render :edit
    end
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body, :tag_names)
    # permit specifies all the input names that are allowes as symbol
  end

  def authorize_user!
    redirect_to root_path, alert: "Not Authorized" unless can?(:crud, @question)
  end
end
