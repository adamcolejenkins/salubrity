class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_resources
  layout 'angular'

  def index
    
  end

  private

  def set_resources
    case params[:resource]
      when 'clinic'
        @resources = current_team.clinics.all
      when 'provider'
        @resources = current_team.providers.all
      when 'survey'
        @resources = current_team.surveys.all
    end
  end
end
