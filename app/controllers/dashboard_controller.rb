class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout 'angular'

  def index
    @surveys = current_team.surveys.all


  end
end
