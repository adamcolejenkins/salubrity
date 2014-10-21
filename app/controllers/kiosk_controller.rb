class KioskController < ApplicationController
  before_action :set_clinic, only: [:new, :create]
  # before_filter :authenticate_user!, only: [:index]
  layout 'kiosk'
  
  def index
    @clinic = JSON.parse(cookies[:_salubrity_kiosk_clinic])
    @survey = JSON.parse(cookies[:_salubrity_kiosk_survey])
  end

  def show
    # @response = Response.new
    # @response.clinic = @clinic
    # @response.survey = @clinic.survey

    # @clinic.survey.fields.each do |field|
    #   @response.answers.build(field: field)
    # end
  end

  def new
    @response = Response.new
    @response.clinic = @clinic
    @response.survey = @clinic.survey

    @response.survey.fields.each do |field|
      @response.answers.build(field: field)
    end
  end

  def create
    @response = Response.new(response_params)
    @response.user_agent = request.user_agent
    @response.ip_address = request.remote_ip
    @response.clinic = @clinic
    @response.survey = @clinic.survey

    if @response.save
      redirect_to kiosk_new_path(params[:guid])
    else

    end

  end

  private

  def set_clinic
    # @clinic ||= Clinic.where(guid: params[:clinic_guid]).survey.where(guid: params[:survey_guid])
    @clinic ||= Clinic.where(guid: params[:guid]).limit(1).first

    if @clinic.blank?
      redirect_to kiosk_path, alert: "That clinic was not found."
    end
  end

  def response_params
    params.require(:response).permit(:clinic_id, :provider_id, :survey_id, :started_at, :ended_at, answers_attributes: [:field_id, :value, :started_at, :ended_at])
  end
end
