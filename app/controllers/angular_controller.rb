class AngularController < ApplicationController
  before_filter :authenticate_user!
  layout 'angular'

  def index
  end

  def template
    render :template => 'angular/' + params[:path], :layout => nil
  end
end
