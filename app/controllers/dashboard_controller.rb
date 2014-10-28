class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout 'angular'

  def index
  end
end
