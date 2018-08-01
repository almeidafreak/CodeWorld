class ApplicationController < ActionController::Base
    before_action :set_i18n_locale_from_params
    protect_from_forgery with: :exception
    
    before_action :execute_search
    def execute_search
        @items = Item.all
    end
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({roles: []}, :firstname, :email,
            :password, :remember_me)}
        devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit({roles: []}, :email,
            :password, :remember_me)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit({roles: []}, :firstname, :email,
            :password)}
    end
    
    def after_sign_in_path_for(resource_or_scope)
        '/profile'
    end
    
    def set_i18n_locale_from_params
        if params[:locale]
            if I18n.available_locales.map(&:to_s).include?(params[:locale])
                I18n.locale = params[:locale]
            else
                flash.now[:notice] =
                "#{params[:locale]} translation not available"
                logger.error flash.now[:notice]
            end
        end
    end
    def default_url_options
        { locale: I18n.locale }
    end
    
end
