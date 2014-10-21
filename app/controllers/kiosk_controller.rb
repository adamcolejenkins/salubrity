class KioskController < ApplicationController
  before_action :set_clinic, only: [:show, :create]
  # before_filter :authenticate_user!, only: [:index]
  layout 'kiosk'
  
  def index
    @clinic = JSON.parse(cookies[:_salubrity_kiosk_clinic])
    @survey = JSON.parse(cookies[:_salubrity_kiosk_survey])
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
    # @clinic ||= Clinic.where(guid: params[:clinic_guid]).survey.where(guid: params[:survey_guid])
    @clinic ||= Clinic.where(guid: params[:guid]).limit(1).first

    if @clinic.blank?
      redirect_to kiosk_path, alert: "That clinic was not found."
    end
  end
end
