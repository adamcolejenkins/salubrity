class Api::ClinicsController < Api::BaseController
  before_action :set_clinic, only: [:show, :update, :destroy]

  # GET /clinics
  # GET /clinics.json
  def index
    @clinics = Clinic.all
    render json: @clinics
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show
    render json: @clinic
  end

  # POST /clinics
  # POST /clinics.json
  def create
    @clinic = Clinic.create!(clinic_params)
    render json: @clinic, status: :created
  end

  # PATCH/PUT /clinics/1
  # PATCH/PUT /clinics/1.json
  def update
    @clinic.update_attributes(clinic_params)
    render json: @clinic, status: :ok
  end

  # DELETE /clinics/1
  # DELETE /clinics/1.json
  def destroy
    @clinic.destroy
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic ||= Clinic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:title, :survey_id, :address, :address2, :city, :state, :zip, :phone, :guid)
    end
end
