class RegistrationsController < ApplicationController
    
    protected
    def after_sign_up_path_for(resource)
        # '/an/example/path' Or :prefix_to_your_route
        edit_user_registration_path
    end
    
end
