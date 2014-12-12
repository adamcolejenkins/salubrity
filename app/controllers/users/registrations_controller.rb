class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout 'angular', :only => [:edit, :update]

  def new
    redirect_to root_path
  end

  def create
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :surname]
    devise_parameter_sanitizer.for(:account_update) << [:name, :surname]
  end

end
