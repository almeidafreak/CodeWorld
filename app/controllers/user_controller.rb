class UserController < ApplicationController
    
    before_action :authenticate_user!
    
    def show
        #@user = User.where(email: current_user.email)
        if current_user.admin
            @users = User.all
        else
            redirect_to root_path
        end
    end
    
    def login
        session[:login] = 1
        flash[:notice] = "You're logged in"
        
        # The line below used to be like the logged out
        # redirect_to :controller => :items
        redirect_to edit_user_registration_path
    end
    
    def logout
        session[:login] = nil
        flash[:notice] = "You have been logged out"
        redirect_to root_path
    end

end
