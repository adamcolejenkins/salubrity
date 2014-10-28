class ClinicsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]
  layout 'angular'

  # GET /clinics
  # GET /clinics.json
  def index
    add_breadcrumb "← Back to Surveys", :surveys_path
    @clinics = survey.clinics.all
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show
    add_breadcrumb "← Back to Clinics", survey_clinics_path(@clinic.survey)
  end

  # GET /clinics/new
  def new
    add_breadcrumb "← Back to Clinics", survey_clinics_path(survey)
    @clinic = survey.clinics.new
  end

  # GET /clinics/1/edit
  def edit
    add_breadcrumb "← Back to Clinics", survey_clinics_path(@clinic.survey)
  end

  # POST /clinics
  # POST /clinics.json
  def create
    @clinic = survey.clinics.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @clinic, notice: 'Clinic was successfully created.' }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1
  # PATCH/PUT /clinics/1.json
  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to @clinic, notice: 'Clinic was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1
  # DELETE /clinics/1.json
  def destroy
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_url, notice: 'Clinic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def survey
      @survey ||= current_team.surveys.find(params[:survey_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:title, :guid, :address, :address2, :city, :state, :zip, :phone)
    end
end
