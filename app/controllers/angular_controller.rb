class AngularController < ApplicationController
  layout 'angular'

  def index
  end

  def template
    render :template => 'angular/' + params[:path], :layout => nil
  end
end
