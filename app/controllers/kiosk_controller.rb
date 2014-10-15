class KioskController < ApplicationController
  before_action :set_clinic, only: [:show, :create]
  
  def index
    @surveys = Survey.all
  end

  def show
    @response = Response.new

    @clinic.survey.fields.each do |field|
      @response.answers.build(field: field)
    end
  end

  def create
    puts request.remote_ip
    puts request.user_agent
  end

  private

  def set_clinic
    @clinic ||= Clinic.where(guid: params[:guid]).limit(1).first

    if @clinic.blank?
      redirect_to kiosk_path, alert: "That clinic was not found."
    end
  end
end
