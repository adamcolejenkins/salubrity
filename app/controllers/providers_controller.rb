class ProvidersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  layout 'angular'

  # GET /providers
  # GET /providers.json
  def index
    add_breadcrumb "← Back to Clinics", survey_clinics_url
    @providers = clinic.providers.all
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
  end

  # GET /providers/new
  def new
    add_breadcrumb "← Back to Providers", survey_clinic_providers_url
    @provider = clinic.providers.new
  end

  # GET /providers/1/edit
  def edit
    add_breadcrumb "← Back to Providers", survey_clinic_providers_url
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = clinic.providers.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to survey_clinic_providers_url, notice: 'Provider was successfully created.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to survey_clinic_providers_url, notice: 'Provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to survey_clinic_providers_url, notice: 'Provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def survey
      @survey ||= current_team.surveys.find(params[:survey_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def clinic
      @clinic = survey.clinics.find(params[:clinic_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = clinic.providers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :position, :email, :phone, :photo)
    end
end
