class KioskController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_clinic, :set_survey, :validate, :check_survey_status, only: [:new, :create]
  layout 'kiosk'
  
  def index
    unless cookies[:_salubrity_kiosk_clinic].nil?
      @clinic = JSON.parse(cookies[:_salubrity_kiosk_clinic])
    end
    unless cookies[:_salubrity_kiosk_survey].nil?
      @survey = JSON.parse(cookies[:_salubrity_kiosk_survey])
    end
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
    @response = current_team.responses.new
    @response.clinic = @clinic
    @response.survey = @survey

    unless @survey.fields.nil?
      @response.survey.fields.each do |field|
        @response.answers.build(field: field)
      end
    end
  end

  def create
    @response = current_team.responses.new(response_params)
    @response.user_agent = request.user_agent
    @response.ip_address = request.remote_ip
    @response.clinic = @clinic
    @response.survey = @survey

    if @response.save
      redirect_to new_response_path
    else

    end

  end

  private

  def set_survey
    @survey ||= @clinic.surveys.where(guid: params[:survey_guid]).limit(1).first
  end

  def set_clinic
    @clinic ||= current_team.clinics.where(guid: params[:clinic_guid]).limit(1).first
  end

  def validate
    if @clinic.nil? || @survey.nil?
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def check_survey_status
    if @survey.status == 'draft'
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def response_params
    params.require(:response).permit(:clinic_id, :provider_id, :survey_id, :started_at, :ended_at, answers_attributes: [:field_id, :value, :started_at, :ended_at])
  end
end
