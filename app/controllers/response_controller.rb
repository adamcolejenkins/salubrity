class ResponseController < ApplicationController
  layout 'frontend'
  
  def index
    @clinic = Clinic.where(guid: params[:guid]).limit(1).first
    
    if @clinic.blank?
      redirect_to root_url, alert: "That clinic was not found."
    end
  end

  def store

  end
end
