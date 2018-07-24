class AdminController < ApplicationController
    
    def login
        session[:login] = 1
        flash[:notice] = "Welcome to your application"
        redirect_to :controller => :items
    end
    
    def logout
        session[:login] = nil
        flash[:notice] = "You have been logged out"
        redirect_to root_path
    end
    
end
