class AngularController < ApplicationController
  load_and_authorize_resource
  layout 'angular'

  def index
  end

  def template
    render :template => 'angular/' + params[:path], :layout => nil
  end
end
