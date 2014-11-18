class ClinicsController < ApplicationController
  load_and_authorize_resource
  before_action :set_clinic, only: [:show, :edit, :update, :destroy, :chart]
  layout 'angular'

  # GET /clinics
  # GET /clinics.json
  def index
    @clinics = current_team.clinics.all
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show
  end

  # GET /clinics/new
  def new
    @clinic = current_team.clinics.new
  end

  # GET /clinics/1/edit
  def edit
  end

  # POST /clinics
  # POST /clinics.json
  def create
    @clinic = current_team.clinics.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to clinics_url, notice: 'Clinic was successfully created.' }
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
        format.html { redirect_to clinics_url, notice: 'Clinic was successfully updated.' }
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

  def chart
    self.send("#{params[:type]}_chart")
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = current_team.clinics.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:title, :guid, :team, :survey, :address, :address2, :city, :state, :zip, :phone, :background)
    end

    # CHARTS
    def responses_chart
      render json: @clinic.responses.group_by_day(:created_at, format: "%A, %B %e").count
    end

    def timing_chart
      render json: @clinic.responses.daily_avg_time
    end

    def multiple_choice_chart
      @field = Field.find(params[:field_id])
      render json: @clinic.data_for(:multiple_choice_field, field: @field)
    end

    def scale_chart
      @field = Field.find(params[:field_id])
      render "fields/_scale.json.jbuilder", locals: { field: @field, resource: @clinic }
    end
end
