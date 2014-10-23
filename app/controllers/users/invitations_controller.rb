class Users::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  layout 'angular', only: [:new, :create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:name, :surname]
  end

end