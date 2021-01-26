#  rails g controller Welcome 👈🏻 Command to generate controller
# rails d controller Welcome 👈🏻 Command to delete controller
class WelcomeController < ApplicationController
    # we call methods inside controller classes: actions
  # so here we have the `index` action
    def index
        # by default (convetion) actions will render view files
        # within a folder that matches the controller name
        # so it will look into the folder called app/views/welcome
        # the view file name should match the action name
        
        # This will render `/app/views/welcome/index.html.erb` .
    end
end
