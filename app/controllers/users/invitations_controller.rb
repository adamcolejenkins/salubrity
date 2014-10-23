class Users::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  layout 'angular', only: [:new, :create]

  # POST /resource/invitation
  def create
    self.resource = invite_resource

    if resource.errors.empty?
      yield resource if block_given?
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      respond_with resource, :location => users_path
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:name, :surname]
  end

end