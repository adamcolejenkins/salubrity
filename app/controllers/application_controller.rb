class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :subdomain, :current_team
  before_filter :validate_subdomain, :authenticate_user!
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def permission_denied
    render file: 'public/401.html', layout: false, status: :unauthorized
  end

  private

  def current_team
    @current_team ||= Team.where(subdomain: subdomain).first
  end

  def subdomain
    request.subdomain
  end

  # This will redirect the user to your 404 page if the account can not be found
  # based on the subdomain.  You can change this to whatever best fits your
  # application.
  def validate_subdomain
    redirect_to '/404.html' if current_team.nil?
  end
end
