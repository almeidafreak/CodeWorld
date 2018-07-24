class UserController < ApplicationController
    
    def login
        session[:login] = 1
        flash[:notice] = "You're logged in"
        
        # The line below used to be like the logged out
        # redirect_to :controller => :items
        redirect_to root_path
    end
    
    def logout
        session[:login] = nil
        flash[:notice] = "You have been logged out"
        redirect_to root_path
    end

end
