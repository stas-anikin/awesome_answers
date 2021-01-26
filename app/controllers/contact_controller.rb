class ContactController < ApplicationController
    def index

    end
    def create
        #all parameters from HTTP or URL comein the HAsh called 'params'
        # params is a Hash with indifferent access meaning that you can access values
        # using string or symbols e.g. params["full_name"] or params[:full_name]
        @full_name=params[:full_name]
        # When we define instance variable in aciotns such as @full_name we can access this in an associated views
    end

end
