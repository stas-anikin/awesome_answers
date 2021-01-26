Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # we map HTTP verb/url combo to a controller#action (action is a method inside the controller class)

  get("/",{to: "welcome#index", as: :root}) 
  # The route above specifies that when your application receives a `GET` request with the URL `/` Rails will handle this request by the `WelcomeController` class and `index` method within that class.
  get("/contact",{to:"contact#index"})# First we have to fetch the form
  post("/contact_submit",{to:"contact#create", as: "contact_submit"})# Then we have to decide where to send the user once form is submitted

  # ROUTES FOR QUESTIONS
  # get('/questions', to:"questions#index")
  # get('/questions/new', to: "questions#new", as: :new_question)
  # post('/questions', to: "questions#create")

  # get('/questions/:id', to: 'questions#show', as: :question)
  # # http://localhost:3000/questions/9
  # delete("/questions/:id",to: "questions#destroy")
  # get('/questions/:id/edit', to: "questions#edit", as: :edit_question)
  # patch('/questions/:id', to: "questions#update")


  # resources will built a CRUD RESTfull routes.(all of the above routes)
  # It assumes that there will be a contoller name as a first argument, pluralized and PascalCase
  # PascalCase
  resources :questions do
    resources :likes, shallow: true, only: [:create, :destroy]

    get :liked, on: :collection
    # All the resources in this block will be prefixed by this👇🏻
    # /questions/:question_id 
    # So we can now grab question_id from params like params[:question_id]

    resources :answers, only:[:create, :destroy] # this will only generate routes for :create and :destroy action
    # /questions/:question_id/answers/:id
    # /questions/:question_id/answers/:id/edit 
  end

  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
  # resource is singular instead of resources
  # Unlike resources, resource will create routes that do CRUD operations only on one thing. 
  # There will be no index routes and no route will have an :id wildcard
  # Even with singular resource controller will still be plural.

  resources :job_posts, only: [:new,:create, :show, :index, :edit,:update, :destroy]

end
