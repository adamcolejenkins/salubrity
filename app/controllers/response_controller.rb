class ResponseController < ApplicationController
  layout 'frontend'
  
  def index
    @survey = Survey.where(guid: params[:guid]).limit(1).first
    
    if @survey.blank?
      redirect_to root_url, alert: "That survey was not found."
    end
  end
end
